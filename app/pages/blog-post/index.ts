import { Request, Response } from "@elements/app";
import { marked } from "marked";
import { getPublishedBySlug, listPublished } from "#app/shared/services/posts";
import html from "./template";

export default function route(req: Request, res: Response) {
  let post = getPublishedBySlug(req.params.slug);
  let more = listPublished().filter((p) => p.id !== post.id).slice(0, 3);

  return new html({ post, html: marked.parse(post.body) as string, more });
}
