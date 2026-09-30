import { Request, Response } from "@elements/app";
import { listFaqs, listPlans } from "#app/shared/services/content";
import { countSignups, findReferrer, waitlistTotal } from "#app/shared/services/waitlist";
import html from "./template";

export default function route(req: Request, res: Response) {
  let listener = waitlistTotal.listen();
  let ref = req.query.ref;

  return new html({
    plans: listPlans(),
    faqs: listFaqs(),
    total: countSignups(),
    listener,
    ref: findReferrer(typeof ref === "string" ? ref : undefined),
  });
}
