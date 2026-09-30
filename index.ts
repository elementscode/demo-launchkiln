import { App, redirect } from "@elements/app";
import config from "#config";
import home from "#app/pages/home";
import waitlist from "#app/pages/waitlist";
import blog from "#app/pages/blog";
import blogPost from "#app/pages/blog-post";
import serveMedia from "#app/routes/media";
import signin from "#app/pages/signin";
import adminWaitlist from "#app/pages/admin-waitlist";
import waitlistCsv from "#app/routes/waitlist-csv";
import adminPosts from "#app/pages/admin-posts";
import adminPost from "#app/pages/admin-post";
import adminPricing from "#app/pages/admin-pricing";
import adminFaq from "#app/pages/admin-faq";
import notFound from "#app/pages/errors/not-found";
import unhandled from "#app/pages/errors/unhandled";

const app = new App();

app.route("/", home);
app.route("/waitlist/:code", waitlist);
app.route("/blog", blog);
app.route("/blog/:slug", blogPost);
app.route("/media/:id/:hash", serveMedia);
app.route("/signin", signin);
app.route("/admin", () => { redirect("/admin/waitlist"); });
app.route("/admin/waitlist", adminWaitlist);
app.route("/admin/waitlist/export", waitlistCsv);
app.route("/admin/posts", adminPosts);
app.route("/admin/posts/:id", adminPost);
app.route("/admin/pricing", adminPricing);
app.route("/admin/faq", adminFaq);

app.error((req, res, err) => {
  switch (err.statusCode) {
    case 404:
      return notFound(req, res, err);

    default:
      return unhandled(req, res, err);
  }
});

app.start(config);
