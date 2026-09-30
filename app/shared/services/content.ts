import { FieldErrors, ValidationError, sql, tx } from "@elements/app";
import { isUserAdminOrThrow } from "#app/shared/services/admin";

export interface Plan {
  id: string;
  name: string;
  priceCents: number;
  blurb: string;
  features: string[];
  cta: string;
  highlighted: boolean;
  sortOrder: number;
}

export interface Faq {
  id: string;
  question: string;
  answer: string;
  sortOrder: number;
}

export function listPlans(): Plan[] {
  return sql<Plan>(`
    select id, name, priceCents, blurb, features, cta, highlighted, sortOrder
      from plans
     order by sortOrder, createdAt
  `).all();
}

export function listFaqs(): Faq[] {
  return sql<Faq>(`
    select id, question, answer, sortOrder
      from faqs
     order by sortOrder, createdAt
  `).all();
}

export function formatPrice(cents: number): string {
  if (cents === 0) {
    return "Free";
  }

  let dollars = cents / 100;

  return `$${Number.isInteger(dollars) ? dollars : dollars.toFixed(2)}`;
}

export interface PlanInput {
  name: string;
  priceCents: number;
  blurb: string;
  features: string[];
  cta: string;
  highlighted: boolean;
  sortOrder: number;
}

export interface FaqInput {
  question: string;
  answer: string;
  sortOrder: number;
}

function checkPlan(input: PlanInput) {
  let errors: FieldErrors<PlanInput> = {};

  if (!input.name.trim()) {
    errors.name = ["Give the plan a name."];
  }

  if (!Number.isInteger(input.priceCents) || input.priceCents < 0) {
    errors.priceCents = ["Enter a price of 0 or more."];
  }

  if (!input.cta.trim()) {
    errors.cta = ["Give the button a label."];
  }

  if (Object.keys(errors).length > 0) {
    throw new ValidationError(errors);
  }
}

/** Creates a plan when id is null. Returns every plan, in display order. @rpc */
export function savePlan(id: string | null, input: PlanInput): Plan[] {
  isUserAdminOrThrow();
  checkPlan(input);

  let features = input.features.map((f) => f.trim()).filter((f) => f.length > 0);

  tx(() => {
    // One plan is featured at most, so featuring this one unfeatures the rest.
    if (input.highlighted) {
      sql(`update plans set highlighted = false where id is distinct from ${id}`);
    }

    if (id) {
      sql(`
        update plans
           set name = ${input.name.trim()},
               priceCents = ${input.priceCents},
               blurb = ${input.blurb.trim()},
               features = ${features},
               cta = ${input.cta.trim()},
               highlighted = ${input.highlighted},
               sortOrder = ${input.sortOrder}
         where id = ${id}
      `);
    } else {
      sql(`
        insert into plans (name, priceCents, blurb, features, cta, highlighted, sortOrder)
             values (${input.name.trim()}, ${input.priceCents}, ${input.blurb.trim()}, ${features}, ${input.cta.trim()}, ${input.highlighted}, ${input.sortOrder})
      `);
    }
  });

  return listPlans();
}

/** @rpc */
export function deletePlan(id: string): Plan[] {
  isUserAdminOrThrow();
  sql(`delete from plans where id = ${id}`);

  return listPlans();
}

/** Creates a question when id is null. Returns every question, in order. @rpc */
export function saveFaq(id: string | null, input: FaqInput): Faq[] {
  isUserAdminOrThrow();

  let errors: FieldErrors<FaqInput> = {};

  if (!input.question.trim()) {
    errors.question = ["Write the question."];
  }

  if (!input.answer.trim()) {
    errors.answer = ["Write the answer."];
  }

  if (Object.keys(errors).length > 0) {
    throw new ValidationError(errors);
  }

  if (id) {
    sql(`
      update faqs
         set question = ${input.question.trim()},
             answer = ${input.answer.trim()},
             sortOrder = ${input.sortOrder}
       where id = ${id}
    `);
  } else {
    sql(`
      insert into faqs (question, answer, sortOrder)
           values (${input.question.trim()}, ${input.answer.trim()}, ${input.sortOrder})
    `);
  }

  return listFaqs();
}

/** @rpc */
export function deleteFaq(id: string): Faq[] {
  isUserAdminOrThrow();
  sql(`delete from faqs where id = ${id}`);

  return listFaqs();
}
