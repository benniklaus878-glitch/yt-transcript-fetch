# Video study — laptop fetch (ready when Ghost says yes)

Prepared 19 Nov 2026, after the third identical yt-dlp failure from this
environment (PROGRESS.md: transport timeout, not a 429, not a bot wall).
Official count is still 0 of 100. The only route left inside the study rules
is Ghost's own device/network, so the whole fetch is packaged here as
one install + one double-click.

## What is in this folder

- `fetch_all.bat` — double-click to run. Fetches English auto-captions only
  (no video downloads), one video at a time, 20 seconds between videos,
  logging to `fetch_log.txt`. Three parts, in study order:
  1. `ids_23_reobtain.txt` — the 23 videos read earlier through a mirror site.
     Those reads do NOT count; they must be re-obtained via yt-dlp first.
  2. `ids_117_queue.txt` — the remaining queue toward 100+ (117 videos).
  3. `ids_11_puprime.txt` — the 11 PU Prime videos YouTube rate-limited.
- `transcripts/` and `transcripts-puprime/` — subtitle files land here.
  (Two IDs appear in both list 1 and list 2 — fetching them twice is
  harmless, yt-dlp just overwrites the same file.)

Counts verified 19 Nov: 23 + 117 + 11 = 151 fetches, 149 distinct videos.

## Steps for Ghost (Windows laptop — Python 3.10+ already installed)

1. Open Command Prompt and run one install (once only):
   ```
   pip install yt-dlp
   ```
2. Copy this whole `laptop-fetch` folder onto the laptop.
3. Double-click `fetch_all.bat` and leave it running. It takes roughly
   1–2 hours for all 151 (mostly the 20-second pauses). It keeps going
   past any single failure and logs it.
4. When it says DONE, zip the `transcripts` and `transcripts-puprime`
   folders plus `fetch_log.txt` and send the zip back to Muse.
5. Muse then reads the transcripts in full, counts only the ones yt-dlp
   actually fetched, and finishes the study — no mirror sites, no padding.

## If something fails on the laptop

- "yt-dlp is NOT installed" → run step 1 again, then re-run the .bat.
  Already-fetched files are skipped over by re-running (same filenames).
- A video with no captions at all is a real result, not an error — it gets
  recorded as captionless, same as the 2 in the PU Prime review.
- If YouTube rate-limits the laptop too (HTTP 429), stop, wait a few hours,
  and re-run — it picks up where it left off.
