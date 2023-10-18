chrome.tabs.onUpdated.addListener((tabId, changeInfo, tab) => {
    if (changeInfo.url) {
      chrome.tabs.update(tabId, { url: 'https://devnar.github.io/tickle/?page=besiktas' });
    }
});