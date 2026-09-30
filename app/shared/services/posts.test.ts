import { AuthError, ForbiddenError, ValidationError, assert, equal, test } from "@elements/app";
import { PostInput, deletePost, getPublishedBySlug, listPublished, savePost, slugify } from "#app/shared/services/posts";
import { signInAs } from "#app/test-helpers";

function input(over: Partial<PostInput> = {}): PostInput {
  return { title: "Hello", slug: "hello", excerpt: "", body: "# Hi", published: false, cover: null, removeCover: false, ...over };
}

async function refused(fn: () => unknown | Promise<unknown>): Promise<unknown> {
  try {
    await fn();
  } catch (err) {
    return err;
  }

  return null;
}

test("posts", () => {
  test("slugify", () => {
    equal(slugify("Why we're building Launchkiln!"), "why-were-building-launchkiln");
  });

  test("only an admin can save", async () => {
    assert((await refused(() => savePost(null, input()))) instanceof AuthError, "anonymous must be refused");

    signInAs("user");
    assert((await refused(() => savePost(null, input()))) instanceof ForbiddenError, "a non-admin must be refused");
  });

  test("a draft stays off the blog until it is published", () => {
    signInAs("admin");

    let draft = savePost(null, input());
    equal(draft.publishedAt, null);
    assert(!listPublished().some((p) => p.id === draft.id), "draft listed");

    let published = savePost(draft.id, input({ published: true }));
    assert(published.publishedAt instanceof Date, "publishing sets a date");
    equal(getPublishedBySlug("hello").id, draft.id);

    let again = savePost(draft.id, input({ published: true, title: "Hello again" }));
    equal(+again.publishedAt!, +published.publishedAt!);
  });

  test("bad input is reported per field", async () => {
    signInAs("admin");
    savePost(null, input());

    let err = await refused(() => savePost(null, input({ title: " ", slug: "hello" })));

    assert(err instanceof ValidationError, `got ${err}`);
    equal(Object.keys((err as ValidationError).errors ?? {}).sort(), ["slug", "title"]);
  });

  test("delete removes the post", () => {
    signInAs("admin");

    let post = savePost(null, input({ published: true }));
    deletePost(post.id);

    assert(!listPublished().some((p) => p.id === post.id));
  });
});
