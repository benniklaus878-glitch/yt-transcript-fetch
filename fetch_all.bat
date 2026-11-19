@echo off
REM Trendline + S&R study — fetch YouTube auto-captions on Ghost's own laptop.
REM Same route the study brief prescribes: yt-dlp, subtitles only, one video at a time.
REM Run by double-clicking this file. It takes a while (151 videos, ~20 seconds
REM pause between each) — leave it running, it logs everything to fetch_log.txt.
REM Subtitles land in transcripts\ (study) and transcripts-puprime\ (PU Prime 11).
REM When it finishes, zip the transcripts folders and send them back to Muse.
setlocal
cd /d "%~dp0"
echo Started %DATE% %TIME% > fetch_log.txt
where yt-dlp >nul 2>&1
if errorlevel 1 (
  echo yt-dlp not found - installing it now, one time only...
  echo Installing yt-dlp... >> fetch_log.txt
  pip install yt-dlp >> fetch_log.txt 2>&1
  if errorlevel 1 py -m pip install yt-dlp >> fetch_log.txt 2>&1
)
where yt-dlp >nul 2>&1
if errorlevel 1 (
  echo yt-dlp still not available after install attempt. See fetch_log.txt
  pause
  exit /b 1
)
if not exist transcripts mkdir transcripts
if not exist transcripts-puprime mkdir transcripts-puprime

echo === 1 of 3: re-obtaining the 23 mirror-read videos (these must count first) ===
for /f %%V in (ids_23_reobtain.txt) do (
  echo [%%V] %TIME% >> fetch_log.txt
  yt-dlp --skip-download --write-auto-subs --sub-langs en --sub-format srt -o "transcripts/%%(id)s.%%(ext)s" "https://www.youtube.com/watch?v=%%V" >> fetch_log.txt 2>&1
  timeout /t 20 /nobreak >nul
)

echo === 2 of 3: the 117-video queue ===
for /f %%V in (ids_117_queue.txt) do (
  echo [%%V] %TIME% >> fetch_log.txt
  yt-dlp --skip-download --write-auto-subs --sub-langs en --sub-format srt -o "transcripts/%%(id)s.%%(ext)s" "https://www.youtube.com/watch?v=%%V" >> fetch_log.txt 2>&1
  timeout /t 20 /nobreak >nul
)

echo === 3 of 3: the 11 unrecovered PU Prime videos ===
for /f %%V in (ids_11_puprime.txt) do (
  echo [%%V] %TIME% >> fetch_log.txt
  yt-dlp --skip-download --write-auto-subs --sub-langs en --sub-format srt -o "transcripts-puprime/%%(id)s.%%(ext)s" "https://www.youtube.com/watch?v=%%V" >> fetch_log.txt 2>&1
  timeout /t 20 /nobreak >nul
)

echo Finished %DATE% %TIME% >> fetch_log.txt
echo.
echo DONE. Check fetch_log.txt for any FAILED lines, then zip the
echo transcripts and transcripts-puprime folders and send them to Muse.
pause
