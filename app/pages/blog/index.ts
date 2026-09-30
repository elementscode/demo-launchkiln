import { Request, Response } from "@elements/app";
import { listPublished } from "#app/shared/services/posts";
import html from "./template";

export default function route(req: Request, res: Response) {
  return new html({ posts: listPublished() });
}
