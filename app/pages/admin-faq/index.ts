import { Request, Response } from "@elements/app";
import { requireAdminPage } from "#app/shared/services/admin";
import { listFaqs } from "#app/shared/services/content";
import html from "./template";

export default function route(req: Request, res: Response) {
  if (!requireAdminPage()) {
    return;
  }

  return new html({ faqs: listFaqs() });
}
