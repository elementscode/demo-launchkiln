import { assert, equal, test } from "@elements/app";
import { findReferrer, joinWaitlist } from "#app/shared/services/waitlist";
import route from "./index";

test("home", () => {
  test("renders with the plans and questions", () => {
    assert(route({ params: {}, query: {} } as any, {} as any) !== undefined);
  });

  test("a referral link names a real signup or nothing", () => {
    let code = joinWaitlist({ email: "ada@example.com", ref: "" });

    equal(findReferrer(code), code);
    equal(findReferrer("made-up"), "");
    assert(route({ params: {}, query: { ref: code } } as any, {} as any) !== undefined);
  });
});
