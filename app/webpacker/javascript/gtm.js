import { onPageLoad } from './utilities/loaders'

onPageLoad(() => {
  window.dataLayer.push({
    event: 'pageView',
    url: window.location.href
  })
})
