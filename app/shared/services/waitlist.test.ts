import { ValidationError, assert, equal, sql, test } from "@elements/app";
import { findReferrer, joinWaitlist, signupPositions } from "#app/shared/services/waitlist";

interface Row {
  email: string;
  referrals: number;
  position: number;
}

function row(email: string): Row {
  return sql<Row>(`select email, referrals, position from signups where email = ${email}`).firstOrThrow();
}

test("waitlist", () => {
  // A position ranks the whole line, so these tests start from an empty one.
  // The test's transaction rolls the delete back, and the seed signups stay.
  sql(`delete from signups`);

  test("a signup joins at the back of the line", () => {
    joinWaitlist({ email: "ada@example.com", ref: "" });
    joinWaitlist({ email: "grace@example.com", ref: "" });

    equal(row("ada@example.com").position, 1);
    equal(row("grace@example.com").position, 2);
  });

  test("the email is normalized and a second join returns the same code", () => {
    let first = joinWaitlist({ email: "  Ada@Example.com ", ref: "" });
    let again = joinWaitlist({ email: "ada@example.com", ref: "" });

    equal(first, again);
    equal(sql<{ n: number }>(`select count(*)::int as n from signups`).firstOrThrow().n, 1);
  });

  test("a bad email is refused", () => {
    let threw = false;

    try {
      joinWaitlist({ email: "not-an-email", ref: "" });
    } catch (err) {
      threw = err instanceof ValidationError;
    }

    assert(threw, "expected a ValidationError");
  });

  test("a referral counts for the referrer and moves them up", () => {
    joinWaitlist({ email: "a@example.com", ref: "" });
    joinWaitlist({ email: "b@example.com", ref: "" });
    let c = joinWaitlist({ email: "c@example.com", ref: "" });

    equal(row("c@example.com").position, 3);

    joinWaitlist({ email: "friend@example.com", ref: c });

    equal(row("c@example.com").referrals, 1);
    equal(row("c@example.com").position, 1);
    equal(row("a@example.com").position, 2);
    equal(row("b@example.com").position, 3);
    equal(row("friend@example.com").position, 4);
  });

  test("an unknown referral code is ignored", () => {
    joinWaitlist({ email: "solo@example.com", ref: "nope" });

    equal(sql<{ referredBy: string | null }>(`select referredBy from signups where email = 'solo@example.com'`).firstOrThrow().referredBy, null);
    equal(findReferrer("nope"), "");
  });

  test("positions stay contiguous when a signup is removed", () => {
    let a = joinWaitlist({ email: "a@example.com", ref: "" });
    joinWaitlist({ email: "b@example.com", ref: a });
    joinWaitlist({ email: "c@example.com", ref: "" });

    sql(`delete from signups where email = 'b@example.com'`);

    equal(row("a@example.com").referrals, 0);
    equal(sql<{ p: number[] }>(`select array_agg(position order by position) as p from signups`).firstOrThrow().p, [1, 2]);
  });

  test("the status page's view carries no email", () => {
    let code = joinWaitlist({ email: "private@example.com", ref: "" });
    let rows = [...signupPositions.view({ code })];

    equal(rows.length, 1);
    equal(rows[0].position, 1);
    assert(!("email" in rows[0]), "the public view must not include an email");
  });
});
