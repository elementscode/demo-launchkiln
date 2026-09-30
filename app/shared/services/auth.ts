import { AuthError, session, sql } from "@elements/app";

export const DEMO_ADMIN = { email: "admin@launchkiln.test", password: "launchkiln" };

/** True when the development seed's admin exists, so its login can be shown. */
export function hasDemoAdmin(): boolean {
  return !sql(`select 1 from users where email = ${DEMO_ADMIN.email}`).empty();
}

/** @rpc */
export function signin(email: string, password: string) {
  let address = email.trim().toLowerCase();

  if (!address || !password) {
    throw new AuthError("Enter your email and password.");
  }

  let user = sql<{ id: string; email: string }>(`
    select id, email
      from users
     where email = ${address}
       and passwordHash = crypt(${password}, passwordHash)
  `).first();

  if (!user) {
    throw new AuthError("That email and password don't match an account.");
  }

  session.login({ userId: user.id, userName: user.email });
}

/** @rpc */
export function signout() {
  session.logout();
}
