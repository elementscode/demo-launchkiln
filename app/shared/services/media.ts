import { sql } from "@elements/app";

export interface MediaBytes {
  id: string;
  name: string;
  contentType: string;
  hash: string;
  data: Buffer;
}

/** The URL for a cover. The hash in it is what makes it safe to cache forever. */
export function coverUrl(coverId: string | null, coverHash: string | null): string {
  return coverId && coverHash ? `/media/${coverId}/${coverHash}` : "";
}

export function readMedia(id: string): MediaBytes {
  return sql<MediaBytes>(`
    select id, name, contentType, hash, data
      from media
     where id = ${id}
  `).firstOrThrow("image not found");
}
