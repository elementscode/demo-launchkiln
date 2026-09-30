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
