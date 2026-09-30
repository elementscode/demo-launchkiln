import { ForbiddenError, ValidationError, assert, equal, sql, test } from "@elements/app";
import { PlanInput, deleteFaq, formatPrice, listFaqs, listPlans, saveFaq, savePlan } from "#app/shared/services/content";
import { signInAs } from "#app/test-helpers";

function plan(over: Partial<PlanInput> = {}): PlanInput {
  return { name: "Team", priceCents: 2500, blurb: "", features: ["One", " ", "Two"], cta: "Join", highlighted: false, sortOrder: 9, ...over };
}

test("site content", () => {
  test("the starting plans and questions are there", () => {
    equal(listPlans().map((p) => p.name), ["Solo", "Studio", "Agency"]);
    assert(listFaqs().length >= 5);
  });

  test("prices read the way the page shows them", () => {
    equal(formatPrice(0), "Free");
    equal(formatPrice(1200), "$12");
    equal(formatPrice(1250), "$12.50");
  });

  test("a non-admin cannot change pricing", () => {
    signInAs("user");

    let threw = false;

    try {
      savePlan(null, plan());
    } catch (err) {
      threw = err instanceof ForbiddenError;
    }

    assert(threw);
  });

  test("a new plan drops blank features, and featuring it unfeatures the rest", () => {
    signInAs("admin");

    let plans = savePlan(null, plan({ highlighted: true }));
    let team = plans.find((p) => p.name === "Team")!;

    equal(team.features, ["One", "Two"]);
    equal(plans.filter((p) => p.highlighted).map((p) => p.name), ["Team"]);
  });

  test("a negative price is refused", () => {
    signInAs("admin");

    let threw = false;

    try {
      savePlan(null, plan({ priceCents: -1 }));
    } catch (err) {
      threw = err instanceof ValidationError;
    }

    assert(threw);
  });

  test("questions can be added, edited and removed", () => {
    signInAs("admin");

    let faqs = saveFaq(null, { question: "Nonprofits?", answer: "Half off.", sortOrder: 0 });
    let added = faqs[0];
    equal(added.question, "Nonprofits?");

    saveFaq(added.id, { question: "Nonprofit discount?", answer: "Half off.", sortOrder: 0 });
    equal(sql<{ q: string }>(`select question as q from faqs where id = ${added.id}`).firstOrThrow().q, "Nonprofit discount?");

    deleteFaq(added.id);
    assert(!listFaqs().some((f) => f.id === added.id));
  });
});
