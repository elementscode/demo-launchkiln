import { equal, test } from "@elements/app";
import { csvField, toCsv } from "#app/routes/waitlist-csv";

test("waitlist csv", () => {
  test("plain values pass through and awkward ones are quoted", () => {
    equal(csvField("ada@example.com"), "ada@example.com");
    equal(csvField(null), "");
    equal(csvField("a,b"), `"a,b"`);
    equal(csvField(`say "hi"`), `"say ""hi"""`);
  });

  test("one header row and one line per signup", () => {
    let csv = toCsv([
      { position: 1, email: "ada@example.com", referrals: 2, referredByEmail: null, code: "abc", createdAt: new Date("2026-09-01T00:00:00Z") },
    ]);

    equal(csv, "position,email,referrals,referred_by,referral_code,joined_at\r\n1,ada@example.com,2,,abc,2026-09-01T00:00:00.000Z\r\n");
  });
});
