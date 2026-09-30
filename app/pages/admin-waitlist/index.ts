import { Request, Response } from "@elements/app";
import { requireAdminPage } from "#app/shared/services/admin";
import { signups } from "#app/shared/services/waitlist";
import html from "./template";

export default function route(req: Request, res: Response) {
  if (!requireAdminPage()) {
    return;
  }

  return new html({ signups: signups.view() });
}
