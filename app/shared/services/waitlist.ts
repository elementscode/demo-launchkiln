import { Channel, ForbiddenError, LiveTable, ValidationError, sql } from "@elements/app";

export interface Signup {
  id: string;
  createdAt: Date;
  email: string;
  code: string;
  referredBy: string | null;
  referrals: number;
  position: number;
}

/** What a signup's own status page may see: no email, theirs or anyone's. */
export interface SignupPosition {
  id: string;
  createdAt: Date;
  code: string;
  referrals: number;
  position: number;
}

export interface JoinForm {
  email: string;
  ref: string;
}

export interface WaitlistTotal {
  total: number;
}

function refuse(): never {
  throw new ForbiddenError("the waitlist is written by joining");
}

// Both tables are read-only from the browser. Writes come from joinWaitlist
// and the triggers in the schema migration, which notify these channels.
export let signups: LiveTable<Signup> = new LiveTable<Signup>({
  channel: (partition) => (partition ? `signups:${partition}` : "signups"),
  insert: refuse,
  update: refuse,
  delete: refuse,
});

export let signupPositions: LiveTable<SignupPosition> = new LiveTable<SignupPosition>({
  table: "signups",
  channel: (partition) => (partition ? `signupPositions:${partition}` : "signupPositions"),
  select: ({ code }) => sql<SignupPosition>(`
    select id, createdAt, code, referrals, position
      from signups
     where code = ${code}
  `),
  insert: refuse,
  update: refuse,
  delete: refuse,
});

export const waitlistTotal = new Channel<WaitlistTotal>("waitlistTotal");

export function countSignups(): number {
  return sql<{ n: number }>(`select count(*)::int as n from signups`).firstOrThrow().n;
}

/** The code of a signup, or "" when no signup has it. */
export function findReferrer(code: string | undefined): string {
  if (!code) {
    return "";
  }

  let row = sql<{ code: string }>(`select code from signups where code = ${code}`).first();

  return row?.code ?? "";
}

export function normalizeEmail(email: string): string {
  return email.trim().toLowerCase();
}

/**
 * Adds an email to the list and returns its referral code. An email already
 * on the list gets its existing code back, so a lost link is one form away.
 * @rpc
 */
export function joinWaitlist(form: JoinForm): string {
  let email = normalizeEmail(form.email);

  if (!/^[^@\s]+@[^@\s]+\.[^@\s]+$/.test(email)) {
    throw new ValidationError("Enter a valid email address.");
  }

  let existing = sql<{ code: string }>(`select code from signups where email = ${email}`).first();

  if (existing) {
    return existing.code;
  }

  let row = sql<{ code: string }>(`
    insert into signups (email, referredBy)
         values (${email}, (select id from signups where code = ${form.ref || null}))
    on conflict (email) do update set email = excluded.email
      returning code
  `).firstOrThrow();

  waitlistTotal.notify({ total: countSignups() });

  return row.code;
}
