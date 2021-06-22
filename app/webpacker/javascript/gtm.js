const registerPageView = () => {
  window.dataLayer.push({
    event: 'pageView',
    url: window.location.href
  });
}

window.addEventListener('turbolinks:load', registerPageView)
