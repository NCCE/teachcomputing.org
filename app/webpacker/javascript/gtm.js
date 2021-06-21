const initGTM = () => {
  gtag('config', process.env.GOOGLE_TAG_MANAGER_KEY, { 'page_location': event.data.url })
}

window.addEventListener('turbolinks:render', initGTM)
