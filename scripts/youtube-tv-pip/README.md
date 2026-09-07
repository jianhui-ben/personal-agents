# PiP Toggle — Floating Video Window

A tiny Chrome extension. **PiP = Picture-in-Picture**: it pops the video out
into a small window that floats on top of everything else, so you can watch a
live game while you code in your terminal.

## How to use
1. Be on a page that's playing a video (YouTube TV, Peacock, YouTube, etc.).
2. Click the toolbar icon **"PiP Toggle — Floating Video Window"**.
3. The video pops into a small floating window. Drag/resize it anywhere.
4. Click the icon again to put it back in the tab.

## Install / update
1. Go to `chrome://extensions`
2. Turn on **Developer mode** (top-right).
3. **Load unpacked** → select this folder:
   `/Users/benben/Projects/personal-agents/scripts/youtube-tv-pip`
4. After editing any file here, click the **↻ reload** icon on the extension card.

## Notes
- Works on basically any site with a video (uses `activeTab` on click).
- It only acts when you click the icon — it does not run automatically.
- It does **not** mute commercials. (The old Peacock version tried to, but live
  sports ads are baked into the broadcast and can't be detected reliably.)
