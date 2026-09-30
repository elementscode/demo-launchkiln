import { session, sql } from "@elements/app";

/** Signs the test's session in as a fresh user with the given role. */
export function signInAs(role: "admin" | "user"): string {
  let user = sql<{ id: string }>(`
    insert into users (email, passwordHash, role)
         values (${`${role}-${Math.random()}@example.com`}, 'x', ${role})
      returning id
  `).firstOrThrow();

  session.login({ userId: user.id, userName: role });

  return user.id;
}
