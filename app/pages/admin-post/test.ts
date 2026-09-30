import { ForbiddenError, assert, sql, test } from "@elements/app";
import { signInAs } from "#app/test-helpers";
import route from "./index";

function render(id: string): unknown {
  return route({ params: { id }, query: {} } as any, {} as any);
}

test("admin post editor", () => {
  test("an admin can open a new post and an existing one", () => {
    signInAs("admin");
    let post = sql<{ id: string }>(`insert into posts (title, slug) values ('Hi', 'hi') returning id`).firstOrThrow();

    assert(render("new") !== undefined);
    assert(render(post.id) !== undefined);
  });

  test("a signed-in non-admin is refused", () => {
    signInAs("user");

    let threw = false;

    try {
      render("new");
    } catch (err) {
      threw = err instanceof ForbiddenError;
    }

    assert(threw, "expected ForbiddenError");
  });
});
