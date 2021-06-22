import { onPageLoad } from './utilities/loader'

onPageLoad(() => {
  window.dataLayer.push({
    event: 'pageView',
    url: window.location.href
  })
})
