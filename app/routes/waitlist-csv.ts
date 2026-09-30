import { Request, Response, sql } from "@elements/app";
import { isUserAdminOrThrow } from "#app/shared/services/admin";

interface Row {
  position: number | null;
  email: string;
  referrals: number;
  referredByEmail: string | null;
  code: string;
  createdAt: Date;
}

/** Quotes a field when it holds a comma, quote, or newline, per RFC 4180. */
export function csvField(value: unknown): string {
  let s = value === null || value === undefined ? "" : value instanceof Date ? value.toISOString() : String(value);

  return /[",\r\n]/.test(s) ? `"${s.replace(/"/g, '""')}"` : s;
}

export function toCsv(rows: Row[]): string {
  let header = ["position", "email", "referrals", "referred_by", "referral_code", "joined_at"];
  let lines = rows.map((r) => [r.position, r.email, r.referrals, r.referredByEmail, r.code, r.createdAt].map(csvField).join(","));

  return [header.join(","), ...lines].join("\r\n") + "\r\n";
}

export default function waitlistCsv(req: Request, res: Response) {
  isUserAdminOrThrow();

  let rows = sql<Row>(`
    select s.position, s.email, s.referrals, r.email as referredByEmail, s.code, s.createdAt
      from signups s
      left join signups r on r.id = s.referredBy
     order by s.position nulls last
  `).all();

  let day = new Date().toISOString().slice(0, 10);

  res.setHeader("Content-Type", "text/csv; charset=utf-8");
  res.setHeader("Content-Disposition", `attachment; filename="launchkiln-waitlist-${day}.csv"`);
  res.setHeader("Cache-Control", "no-store");
  res.end(toCsv(rows));
}
