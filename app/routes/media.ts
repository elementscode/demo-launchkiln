import { Request, Response } from "@elements/app";
import { readMedia } from "#app/shared/services/media";

// Types we render on our own origin. Anything else goes out as a download.
const INLINE = new Set(["image/png", "image/jpeg", "image/gif", "image/webp", "image/svg+xml"]);

const YEAR = 31536000;

export default function serveMedia(req: Request, res: Response) {
  let m = readMedia(req.params.id);

  if (req.params.hash !== m.hash) {
    res.status(404);
    return res.end();
  }

  if (INLINE.has(m.contentType)) {
    res.setHeader("Content-Type", m.contentType);
  } else {
    res.setHeader("Content-Type", "application/octet-stream");
    res.setHeader("Content-Disposition", "attachment");
  }

  // An svg can carry script. This keeps any it has from running when the
  // image is opened directly.
  res.setHeader("Content-Security-Policy", "default-src 'none'; style-src 'unsafe-inline'");
  res.setHeader("Cache-Control", `public, max-age=${YEAR}, immutable`);

  return m.data;
}
