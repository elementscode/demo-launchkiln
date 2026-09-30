import { assert, test } from "@elements/app";
import route from "./index";

test("blog index renders", () => {
  assert(route({ params: {}, query: {} } as any, {} as any) !== undefined);
});
