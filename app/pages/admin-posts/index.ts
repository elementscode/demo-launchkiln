import { Request, Response } from "@elements/app";
import { requireAdminPage } from "#app/shared/services/admin";
import { listAll } from "#app/shared/services/posts";
import html from "./template";

export default function route(req: Request, res: Response) {
  if (!requireAdminPage()) {
    return;
  }

  return new html({ posts: listAll() });
}
