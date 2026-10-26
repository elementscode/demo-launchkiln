![A marketing site with a referral waitlist, built by Claude Code on Elements: the home page hero with an invoice stamped paid, a payment notification and the waitlist form.](https://elements.dev/demos/01a0f417-e8ad-7900-b01b-5aee50c6ca2f/poster?v=cc1da6193af1)

# A marketing site with a referral waitlist, built by Claude Code on Elements

> Launchkiln is a full-stack app built with Claude Code on Elements.

A home page with pricing and FAQ, a blog, and a waitlist where referral links move people up the list live, plus an admin for posts, plans and CSV export.

[Run this app on your machine](https://elements.dev/demos/01a0f417-e8ad-7900-b01b-5aee50c6ca2f). Use this demo as inspiration, or as the starting point for your own app. Your agent creates a new app with this one as the scaffold, and you prompt it to add whatever features you want.

## How it's built

Launchkiln needed a waitlist where every referral reorders the line and each signup watches their own place move, a blog with cover images, and admin pages for posts, pricing and the FAQ. Each of those is a part of Elements, so the agent spent its 23 minutes on the launch site itself.

- **Live waitlist positions.** Signups are a LiveTable. Each referral reorders the line in the database, and only the signups whose place changed hear about it, so a status page shows its own position and referral count moving as friends join.

- **A live signup count.** A channel carries the total, so the home page and every status page show the list growing as people join.

- **Server calls as function calls.** Joining the waitlist is one `@rpc` call that returns the referral link, and an email already on the list gets its existing link back. The admin saves posts, pricing plans and FAQ entries the same way, with the cover image sent along in the same call.

- **Covers and export.** Blog covers are stored in the database and served at addresses browsers keep for a year, and the admin downloads the waitlist as a CSV.

- **Data from SQL files.** Migrations define the site, load three pricing plans and six FAQ entries everywhere, and seed the admin, four posts with drawn covers and 200 signups, about a third of them referred.

- **Sessions and roles.** Every admin page, server call and the export share one guard on the admin role.

## Why Elements

Elements is an integrated full-stack app framework and a project server. The project server checks the agent's work as it builds: it type-checks the server and browser code, analyzes the program, applies migrations and runs the tests, then reports the results to the agent. A security mistake, such as calling a server-only function from the browser, is a compile error. The agent reads the report and fixes its own mistakes before it tells you a feature is done. The same checks run on every feature you ask for next.
