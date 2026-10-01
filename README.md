![Launchkiln, a prelaunch marketing site built with Elements: the home page hero with an invoice stamped paid, a payment notification and the waitlist form.](https://elements.dev/demos/01a0f417-e8ad-7900-b01b-5aee50c6ca2f/poster?v=cc1da6193af1)

# Launchkiln

> A demo app built with [Elements](https://elements.dev).

A home page with pricing and FAQ, a blog, and a waitlist where referral links move people up the list live, plus an admin for posts, plans and CSV export.

**Demo:** [Launchkiln](https://elements.dev/demos/01a0f417-e8ad-7900-b01b-5aee50c6ca2f)

## Agent specs

What one run of the prompt below took, from an empty Elements project to this
app.

- **Agent:** Claude Code, Opus 5.5 Medium
- **Time:** 23 min
- **Cost:** $7.96 at API rates, September 2026

## Get started

```bash
elements create launchkiln -scaffold=elementscode/demo-launchkiln
```

## How it's built

Launchkiln needed a waitlist where every referral reorders the line and each signup watches their own place move, a blog with cover images, and admin pages for posts, pricing and the FAQ. Each of those is a part of Elements, so the agent spent its 23 minutes on the launch site itself.

### What Elements gave the app

- **Live waitlist positions.** `signups` and `signupPositions` are LiveTables in `app/shared/services/waitlist.ts`. Triggers in the schema migration count each referral, rerank the line and broadcast only the rows whose place changed. `signupPositions` is partitioned by referral code, so each status page hears its own row, in its public columns.
- **A live signup count.** `waitlistTotal` is a Channel in the same file. `joinWaitlist` publishes the new total, and the home and status pages listen for it.
- **Server calls as function calls.** The join form calls `joinWaitlist`, an `@rpc` that returns the referral code, or the existing code for an email already on the list. The admin pages call `savePost`, `savePlan` and `saveFaq` the same way, and `savePost` takes the cover image file as an argument.
- **Covers from the database.** Covers live in the `media` table, and `app/routes/media.ts` serves each one at a hashed url that browsers cache for a year. `app/routes/waitlist-csv.ts` returns the waitlist as a CSV export for the admin.
- **Data from SQL files.** Three migrations define the site, load three pricing plans and six FAQ entries in every environment, and seed the admin, four posts with drawn covers and 200 signups, about a third of them referred.
- **Sessions and roles.** Every admin page, rpc and the export share one guard, `isUserAdminOrThrow` in `app/shared/services/admin.ts`.

### What the agent got from the tooling

The agent ran 40 builds in 23 minutes. By the build's own timer, its timed builds finished in 156 and 431 milliseconds, so it checked its work after each edit and kept going. The build caught errors in six of them, among them a malformed `e:for` loop variable and a page imported into another page, each with a message that named the fix. The agent read the manual for each part as it reached it, 54 topics from `channel` and `recipes/live-dashboard` to `style/components/tabs`, then wrote 52 tests and checked its pages in a real browser.

Start in `app/shared/services/waitlist.ts`.

## Seed data and demo account

The seed creates one admin, four published blog posts with drawn SVG covers,
three pricing plans, six FAQ entries, and 200 waitlist signups from the past
five weeks, about a third of them referred by another signup. The sign-in page
shows the admin login and fills it in for you.

| Email                  | Password     | Role  |
| ---------------------- | ------------ | ----- |
| admin@launchkiln.test  | `launchkiln` | admin |

- `/` is the home page. Joining the waitlist takes you to `/waitlist/<code>`,
  your place in line and your referral link. The page updates live as the
  list moves.
- `/blog` lists the posts.
- `/admin` is the admin: waitlist (with CSV export), blog posts, pricing and
  FAQ.

The admin, the posts and the signups load only in development. The plans and
FAQ load in every environment.

## The prompt

```text
Build a marketing site named launchkiln for a new invoicing product that is not
launched yet.

PUBLIC
- Home: hero, three feature sections with screenshots, testimonials, pricing
  with three plans, FAQ, footer.
- Blog: an index and post pages.
- Join the waitlist with an email. Each signup gets a referral link; every
  friend who joins through it moves them up the list. A page shows their
  position and referrals.

ADMIN
- Write blog posts in markdown with a cover image, draft or published.
- Waitlist: signups, referral counts, export as CSV.
- Edit the pricing plans and FAQ.

Seed the admin, four blog posts with covers, and 200 waitlist signups with
referrals. Show the admin login on the sign-in page.

Waitlist positions update in real time.
```

## License

MIT. See [LICENSE](LICENSE).
