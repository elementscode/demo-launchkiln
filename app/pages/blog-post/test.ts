import { NotFoundError, assert, sql, test } from "@elements/app";
import route from "./index";

function render(slug: string): unknown {
  return route({ params: { slug }, query: {} } as any, {} as any);
}

test("blog post", () => {
  test("a published post renders", () => {
    sql(`insert into posts (title, slug, body, publishedAt) values ('Hi', 'hi', '## Hello', now())`);

    assert(render("hi") !== undefined);
  });

  test("a draft is a 404", () => {
    sql(`insert into posts (title, slug, body) values ('Draft', 'draft', 'wip')`);

    let threw = false;

    try {
      render("draft");
    } catch (err) {
      threw = err instanceof NotFoundError;
    }

    assert(threw, "expected NotFoundError");
  });
});
