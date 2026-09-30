import { NotFoundError, assert, test } from "@elements/app";
import { joinWaitlist } from "#app/shared/services/waitlist";
import route from "./index";

function request(code: string): any {
  return { params: { code }, query: {}, headers: { host: "launchkiln.test" } };
}

test("waitlist status page", () => {
  test("renders for a signup's code", () => {
    let code = joinWaitlist({ email: "ada@example.com", ref: "" });

    assert(route(request(code), {} as any) !== undefined, "expected a page");
  });

  test("an unknown code is a 404", () => {
    let threw = false;

    try {
      route(request("missing"), {} as any);
    } catch (err) {
      threw = err instanceof NotFoundError;
    }

    assert(threw, "expected NotFoundError");
  });
});
