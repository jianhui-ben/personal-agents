// Peacock Ad Selector Spy
// Paste this into DevTools console on Peacock while watching a video.
// When an ad starts/ends, it logs all new/removed elements with their selectors.
// Copy the output and share it to update content.js with real ad selectors.

(function () {
  const seen = new Set();

  function describe(el) {
    if (!(el instanceof Element)) return null;
    const tag = el.tagName.toLowerCase();
    const id = el.id ? `#${el.id}` : '';
    const classes = el.className && typeof el.className === 'string'
      ? '.' + el.className.trim().split(/\s+/).join('.')
      : '';
    const dataAttrs = Array.from(el.attributes)
      .filter(a => a.name.startsWith('data-') || a.name.startsWith('aria-'))
      .map(a => `[${a.name}="${a.value}"]`)
      .join('');
    return `${tag}${id}${classes}${dataAttrs}`;
  }

  function isPlayerArea(el) {
    // Only care about elements inside or near the video player
    return el.closest
      ? el.closest('[class*="player"], [class*="Player"], [class*="video"], [class*="Video"]') !== null
      : true;
  }

  const observer = new MutationObserver((mutations) => {
    for (const mutation of mutations) {
      for (const node of mutation.addedNodes) {
        if (!(node instanceof Element)) continue;
        const desc = describe(node);
        if (!desc || seen.has('ADD:' + desc)) continue;
        if (isPlayerArea(node) || node.className?.toString().match(/ad|Ad|commercial|overlay/i)) {
          seen.add('ADD:' + desc);
          console.log('%c[AD SPY] ADDED', 'color: #4CAF50; font-weight: bold', desc, node);
        }
        // Also check children
        node.querySelectorAll('*').forEach(child => {
          const cdesc = describe(child);
          if (!cdesc || seen.has('ADD:' + cdesc)) return;
          if (cdesc.match(/ad|Ad|overlay|Overlay|countdown|Countdown|commercial/i)) {
            seen.add('ADD:' + cdesc);
            console.log('%c[AD SPY] ADDED (child)', 'color: #8BC34A', cdesc, child);
          }
        });
      }

      for (const node of mutation.removedNodes) {
        if (!(node instanceof Element)) continue;
        const desc = describe(node);
        if (!desc || seen.has('REM:' + desc)) continue;
        if (desc.match(/ad|Ad|overlay|Overlay|countdown|Countdown|commercial/i)) {
          seen.add('REM:' + desc);
          console.log('%c[AD SPY] REMOVED', 'color: #FF5722; font-weight: bold', desc);
        }
      }
    }
  });

  observer.observe(document.body, {
    childList: true,
    subtree: true,
    attributes: true,
    attributeFilter: ['class', 'data-testid', 'aria-label']
  });

  console.log('%c[AD SPY] Running — wait for an ad to start, then check this log.', 'color: #2196F3; font-weight: bold');
  console.log('%c[AD SPY] To stop: adSpy.disconnect()', 'color: #2196F3');
  window.adSpy = observer;
})();
