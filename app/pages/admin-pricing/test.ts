import { ForbiddenError, assert, test } from "@elements/app";
import { signInAs } from "#app/test-helpers";
import route from "./index";

test("admin-pricing", () => {
  test("an admin sees the page", () => {
    signInAs("admin");

    assert(route({ params: {}, query: {} } as any, {} as any) !== undefined);
  });

  test("a signed-in non-admin is refused", () => {
    signInAs("user");

    let threw = false;

    try {
      route({ params: {}, query: {} } as any, {} as any);
    } catch (err) {
      threw = err instanceof ForbiddenError;
    }

    assert(threw, "expected ForbiddenError");
  });
});
