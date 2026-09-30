import { FieldErrors, File, ValidationError, sql, tx } from "@elements/app";
import { isUserAdminOrThrow } from "#app/shared/services/admin";

export interface Post {
  id: string;
  updatedAt: Date;
  title: string;
  slug: string;
  excerpt: string;
  body: string;
  coverId: string | null;
  coverHash: string | null;
  publishedAt: Date | null;
}

export interface PostInput {
  title: string;
  slug: string;
  excerpt: string;
  body: string;
  published: boolean;
  cover: File | null;
  removeCover: boolean;
}

// Only raster types are accepted from the editor: an uploaded svg could carry
// script onto our own origin.
const COVER_TYPES = new Set(["image/png", "image/jpeg", "image/webp", "image/gif"]);

const MAX_COVER_BYTES = 5 * 1024 * 1024;

const COLUMNS = sql.raw(`
  p.id, p.updatedAt, p.title, p.slug, p.excerpt, p.body, p.coverId, p.publishedAt,
  m.hash as coverHash
`);

export function listPublished(): Post[] {
  return sql<Post>(`
    select ${COLUMNS}
      from posts p
      left join media m on m.id = p.coverId
     where p.publishedAt is not null and p.publishedAt <= now()
     order by p.publishedAt desc
  `).all();
}

export function getPublishedBySlug(slug: string): Post {
  return sql<Post>(`
    select ${COLUMNS}
      from posts p
      left join media m on m.id = p.coverId
     where p.slug = ${slug} and p.publishedAt is not null and p.publishedAt <= now()
  `).firstOrThrow("post not found");
}

export function listAll(): Post[] {
  return sql<Post>(`
    select ${COLUMNS}
      from posts p
      left join media m on m.id = p.coverId
     order by p.updatedAt desc
  `).all();
}

export function getById(id: string): Post {
  return sql<Post>(`
    select ${COLUMNS}
      from posts p
      left join media m on m.id = p.coverId
     where p.id = ${id}
  `).firstOrThrow("post not found");
}

export function readingMinutes(body: string): number {
  return Math.max(1, Math.round(body.split(/\s+/).length / 220));
}

export function slugify(title: string): string {
  return title
    .toLowerCase()
    .replace(/['’]/g, "")
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-+|-+$/g, "");
}

/** @rpc */
export function savePost(id: string | null, input: PostInput): Post {
  isUserAdminOrThrow();

  let errors: FieldErrors<PostInput> = {};

  if (input.title.trim().length === 0) {
    errors.title = ["Give the post a title."];
  }

  if (!/^[a-z0-9]+(-[a-z0-9]+)*$/.test(input.slug)) {
    errors.slug = ["Use lowercase letters, numbers, and single dashes."];
  }

  if (input.cover && !COVER_TYPES.has(input.cover.contentType)) {
    errors.cover = ["Upload a PNG, JPEG, WebP, or GIF."];
  } else if (input.cover && input.cover.size > MAX_COVER_BYTES) {
    errors.cover = ["Covers can be up to 5 MB."];
  }

  let taken = sql(`select 1 from posts where slug = ${input.slug} and id is distinct from ${id}`).empty() === false;

  if (taken) {
    errors.slug = ["Another post already uses this slug."];
  }

  if (Object.keys(errors).length > 0) {
    throw new ValidationError(errors);
  }

  return tx(() => {
    let current = id ? getById(id) : null;
    let coverId = input.removeCover ? null : current?.coverId ?? null;

    if (input.cover) {
      coverId = sql<{ id: string }>(`
        insert into media (name, contentType, data)
             values (${input.cover.name}, ${input.cover.contentType}, ${input.cover.data})
          returning id
      `).firstOrThrow().id;
    }

    // Publishing keeps the original date; unpublishing clears it. The date
    // comes from the database clock, the same one the blog filters against.
    let publishedAt = input.published ? current?.publishedAt ?? null : null;

    let saved = id
      ? sql<{ id: string }>(`
          update posts
             set title = ${input.title.trim()},
                 slug = ${input.slug},
                 excerpt = ${input.excerpt.trim()},
                 body = ${input.body},
                 coverId = ${coverId},
                 publishedAt = case when ${input.published} then coalesce(${publishedAt}::timestamptz, now()) end
           where id = ${id}
          returning id
        `).firstOrThrow("post not found")
      : sql<{ id: string }>(`
          insert into posts (title, slug, excerpt, body, coverId, publishedAt)
               values (${input.title.trim()}, ${input.slug}, ${input.excerpt.trim()}, ${input.body}, ${coverId}, case when ${input.published} then now() end)
            returning id
        `).firstOrThrow();

    if (current?.coverId && current.coverId !== coverId) {
      sql(`delete from media where id = ${current.coverId}`);
    }

    return getById(saved.id);
  });
}

/** @rpc */
export function deletePost(id: string) {
  isUserAdminOrThrow();

  tx(() => {
    let post = getById(id);
    sql(`delete from posts where id = ${id}`);

    if (post.coverId) {
      sql(`delete from media where id = ${post.coverId}`);
    }
  });
}
