// Toolbar icon click -> inject the PiP toggle directly into the page.
// Injecting on the action click preserves the user gesture that the
// Picture-in-Picture API requires (a background message would lose it).

function togglePiPInPage() {
  const videos = Array.from(document.querySelectorAll('video'));
  if (!videos.length) return;
  const playing = videos.filter(v => !v.paused && v.readyState >= 2);
  const pool = playing.length ? playing : videos;
  const video = pool.reduce((a, b) =>
    (a.videoWidth * a.videoHeight) >= (b.videoWidth * b.videoHeight) ? a : b);
  if (!video) return;

  if (video.disablePictureInPicture) video.disablePictureInPicture = false;

  if (document.pictureInPictureElement) {
    document.exitPictureInPicture().catch(() => {});
  } else {
    video.requestPictureInPicture().catch((e) =>
      console.warn('[YouTube TV PiP] PiP failed:', e && e.message));
  }
}

chrome.action.onClicked.addListener((tab) => {
  if (!tab || !tab.id) return;
  chrome.scripting.executeScript({
    target: { tabId: tab.id, allFrames: true },
    func: togglePiPInPage
  }).catch((e) => console.warn('[YouTube TV PiP] inject failed:', e && e.message));
});
