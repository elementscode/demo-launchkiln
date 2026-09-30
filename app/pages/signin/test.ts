import { AuthError, assert, session, sql, test } from "@elements/app";
import { signin } from "#app/shared/services/auth";
import route from "./index";

test("signin", () => {
  test("renders for a visitor", () => {
    assert(route({ params: {}, query: {} } as any, {} as any) !== undefined);
  });

  test("the right password signs in and a wrong one does not", () => {
    sql(`insert into users (email, passwordHash, role) values ('boss@example.com', crypt('secret-pass', genSalt('bf', 4)), 'admin')`);

    let threw = false;

    try {
      signin("boss@example.com", "wrong");
    } catch (err) {
      threw = err instanceof AuthError;
    }

    assert(threw, "wrong password must be refused");
    assert(!session.isLoggedIn());

    signin(" Boss@Example.com ", "secret-pass");
    assert(session.isLoggedIn());
  });
});
