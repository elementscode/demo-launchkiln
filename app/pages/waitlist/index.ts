import { NotFoundError, Request, Response, sql } from "@elements/app";
import { countSignups, signupPositions, waitlistTotal } from "#app/shared/services/waitlist";
import html from "./template";

export default function route(req: Request, res: Response) {
  let code = req.params.code;

  if (sql(`select 1 from signups where code = ${code}`).empty()) {
    throw new NotFoundError("no signup with that link");
  }

  let listener = waitlistTotal.listen();
  let host = req.headers.host ?? "localhost";
  let proto = req.headers["x-forwarded-proto"] ?? "http";

  return new html({
    positions: signupPositions.view({ code }),
    total: countSignups(),
    listener,
    link: `${proto}://${host}/?ref=${code}`,
  });
}
