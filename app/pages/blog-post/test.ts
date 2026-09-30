import { NotFoundError, assert, sql, test } from "@elements/app";
import route from "./index";

function render(slug: string): unknown {
  return route({ params: { slug }, query: {} } as any, {} as any);
}

test("blog post", () => {
  test("a published post renders", () => {
    let slug = `hi-${crypto.randomUUID().slice(0, 8)}`;
    sql(`insert into posts (title, slug, body, publishedAt) values ('Hi', ${slug}, '## Hello', now())`);

    assert(render(slug) !== undefined);
  });

  test("a draft is a 404", () => {
    let slug = `draft-${crypto.randomUUID().slice(0, 8)}`;
    sql(`insert into posts (title, slug, body) values ('Draft', ${slug}, 'wip')`);

    let threw = false;

    try {
      render(slug);
    } catch (err) {
      threw = err instanceof NotFoundError;
    }

    assert(threw, "expected NotFoundError");
  });
});
