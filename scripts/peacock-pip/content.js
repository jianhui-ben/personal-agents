// Peacock PiP Content Script
// Receives AD_START/AD_END from background.js and mutes/unmutes the video
// Also handles auto Picture-in-Picture

let currentVideo = null;

function getMainVideo() {
  const videos = Array.from(document.querySelectorAll('video'));
  if (!videos.length) return null;
  // Pick the playing or largest video
  const playing = videos.filter(v => !v.paused && v.readyState >= 2);
  if (playing.length === 1) return playing[0];
  if (playing.length > 1) {
    return playing.reduce((a, b) =>
      (a.videoWidth * a.videoHeight) >= (b.videoWidth * b.videoHeight) ? a : b);
  }
  return videos.reduce((a, b) =>
    (a.videoWidth * a.videoHeight) >= (b.videoWidth * b.videoHeight) ? a : b);
}

async function enterPiP(video) {
  if (!video || !document.pictureInPictureEnabled) return;
  if (document.pictureInPictureElement === video) return;
  try {
    if (document.pictureInPictureElement) await document.exitPictureInPicture();
    await video.requestPictureInPicture();
    currentVideo = video;
    console.log('[Peacock PiP] Entered PiP');
  } catch (e) {
    console.warn('[Peacock PiP] PiP failed:', e.message);
  }
}

// Listen for ad state messages from background.js
chrome.runtime.onMessage.addListener(async (msg) => {
  const video = getMainVideo();
  if (!video) return;

  if (msg.type === 'AD_START') {
    video.muted = true;
    // Exit PiP during ads — hides the floating window
    if (document.pictureInPictureElement) {
      await document.exitPictureInPicture();
      console.log('[Peacock PiP] Ad started — PiP hidden, muted');
    }
  } else if (msg.type === 'AD_END') {
    video.muted = false;
    // Re-enter PiP when game resumes
    await enterPiP(video);
    console.log('[Peacock PiP] Game resumed — PiP restored, unmuted');
  }
});

// Auto-enter PiP on first play
document.addEventListener('play', async (e) => {
  if (e.target.tagName !== 'VIDEO') return;
  await new Promise(r => setTimeout(r, 300));
  const video = getMainVideo();
  if (video && !document.pictureInPictureElement) enterPiP(video);
}, true);

console.log('[Peacock PiP] v2 loaded — using network-based ad detection');
