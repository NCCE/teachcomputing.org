import { onPageLoad } from "./utilities/loaders"

onPageLoad(() => {
  document.body.classList.add('js-enabled')

  if ('noModule' in HTMLScriptElement.prototype) {
    document.body.classList.add('govuk-frontend-supported')
  }
})