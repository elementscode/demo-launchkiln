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

- **Live waitlist positions.** Signups are a LiveTable. Each referral reorders the line in the database, and only the signups whose place changed hear about it, so a status page shows its own position and referral count moving as friends join.

- **A live signup count.** A channel carries the total, so the home page and every status page show the list growing as people join.

- **Server calls as function calls.** Joining the waitlist is one `@rpc` call that returns the referral link, and an email already on the list gets its existing link back. The admin saves posts, pricing plans and FAQ entries the same way, with the cover image sent along in the same call.

- **Covers and export.** Blog covers are stored in the database and served at addresses browsers keep for a year, and the admin downloads the waitlist as a CSV.

- **Data from SQL files.** Migrations define the site, load three pricing plans and six FAQ entries everywhere, and seed the admin, four posts with drawn covers and 200 signups, about a third of them referred.

- **Sessions and roles.** Every admin page, server call and the export share one guard on the admin role.

### What the project server gave the agent

The project server runs alongside the agent and answers as soon as a file is saved: it type-checks the templates, TypeScript and SQL, applies migrations and reruns the tests, so every question came back right away and the agent kept building.

### What shipped

The app type-checks with zero errors and all 52 tests pass. Every page works on desktop and phone.

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
