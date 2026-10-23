# ADR-0010: Narration audio in PostgreSQL for release 1, object storage as the target

- **Status:** Accepted · 2026-10-21, revised 2026-10-23 · Owner: Yernar Katyshev
- **Context:** With client-side rendering (ADR-0008) the server stores only the narration (WAV, ≈4.3 MB per 90 s; ≈1.3 GB for 300 videos) and the script with timings. The audio must:
  - stream to phones with seeking (HTTP range requests; Safari requires them);
  - be visible only to members of the goal;
  - be deleted with the goal and the owner's data (FR-04).
- **Decision:**
  - Release 1 stores the narration as PostgreSQL `bytea` next to the video row and serves it through an authenticated route with range support.
  - It is deleted in the same transaction as its row, by cascade from the goal.
  - Move to S3-compatible object storage (Cloudflare R2 or Railway Storage Buckets through the same SDK) when stored media exceed about 5 GB, when server-side video files are added, or when media must be served through a CDN.
- **Alternatives** ([05 D11](../05-technology-comparison.md#d11-media-storage-for-narration-audio)):
  - S3-compatible object storage (4.55): cheaper per GB and CDN-friendly, at the cost of a second storage system and eventually consistent deletion;
  - a volume on the app host (3.20): blocks replicas, downtime on redeploy, 5 GB cap on Hobby.
- **Consequences:**
  - (+) one storage system, transactional deletion, simple access control;
  - (−) media in every database backup and bytes streamed through Node; acceptable at pilot volume.
