import { Request, Response } from "@elements/app";
import { requireAdminPage } from "#app/shared/services/admin";
import { Post, getById } from "#app/shared/services/posts";
import html from "./template";

export default function route(req: Request, res: Response) {
  if (!requireAdminPage()) {
    return;
  }

  if (req.params.id === "new") {
    let blank: Post = {
      id: "",
      updatedAt: new Date(),
      title: "",
      slug: "",
      excerpt: "",
      body: "",
      coverId: null,
      coverHash: null,
      publishedAt: null,
    };

    return new html({ post: blank, isNew: true });
  }

  return new html({ post: getById(req.params.id), isNew: false });
}
