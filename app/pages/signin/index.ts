import { Request, Response, redirect, session } from "@elements/app";
import { DEMO_ADMIN, hasDemoAdmin } from "#app/shared/services/auth";
import html from "./template";

export default function route(req: Request, res: Response) {
  if (session.isLoggedIn()) {
    redirect("/admin");
    return;
  }

  return new html({ demo: hasDemoAdmin() ? DEMO_ADMIN : null });
}
