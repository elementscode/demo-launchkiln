import { ForbiddenError, redirect, sql, session } from "@elements/app";

export function isUserAdmin(userId: string): boolean {
  return !sql(`select 1 from users where id = ${userId} and role = 'admin'`).empty();
}

export function isUserAdminOrThrow() {
  session.isLoggedInOrThrow();

  if (!isUserAdmin(session.getOrThrow("userId"))) {
    throw new ForbiddenError("admin access required");
  }
}

/**
 * The guard for admin pages. A visitor who is not signed in is sent to sign
 * in rather than shown an error; a signed-in non-admin gets a 403.
 */
export function requireAdminPage(): boolean {
  if (!session.isLoggedIn()) {
    redirect("/signin");
    return false;
  }

  isUserAdminOrThrow();

  return true;
}
