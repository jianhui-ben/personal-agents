// Background service worker — monitors network requests to ad domains
// Sends mute/unmute messages to the Peacock content script

const AD_DOMAINS = [
  'fwmrm.net',       // FreeWheel (Peacock's primary ad server)
  'doubleclick.net',
  '2mdn.net',
  'googlevideo.com',
  'spotxchange.com',
  'tidaltv.com',
  'adsby.bidtheatre.com',
];

// Track ad state per tab
const adState = {}; // tabId -> { adActive: bool, timer: timeoutId }

function isAdUrl(url) {
  return AD_DOMAINS.some(domain => url.includes(domain));
}

function setAdActive(tabId, active) {
  const prev = adState[tabId]?.adActive;
  if (prev === active) return;

  if (!adState[tabId]) adState[tabId] = {};
  adState[tabId].adActive = active;

  // Clear existing timeout
  if (adState[tabId].timer) clearTimeout(adState[tabId].timer);

  chrome.tabs.sendMessage(tabId, { type: active ? 'AD_START' : 'AD_END' })
    .catch(() => {}); // tab may not have content script yet

  if (active) {
    // Auto-clear ad state after 3 minutes (safety net if AD_END never fires)
    adState[tabId].timer = setTimeout(() => setAdActive(tabId, false), 180000);
  }
}

// Watch for requests to ad delivery domains
chrome.webRequest.onBeforeRequest.addListener(
  (details) => {
    if (isAdUrl(details.url)) {
      setAdActive(details.tabId, true);

      // Schedule ad end: ad video segments are typically 15-30s
      // Reset the timer on each new ad request to extend the window
      if (adState[details.tabId]?.timer) clearTimeout(adState[details.tabId].timer);
      adState[details.tabId].timer = setTimeout(() => {
        setAdActive(details.tabId, false);
      }, 8000); // if no new ad requests in 8s, assume ad ended
    }
  },
  { urls: ["<all_urls>"] }
);
