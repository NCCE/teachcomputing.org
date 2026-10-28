import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  AJAX_LISTENERS = { rate: 'rate', choices: 'choices', comment: 'comment' }
  static targets = ['page', 'ratingId']
  clearText = true
  retrievedRatingId = ''
  requestInFlight = false

  initialize() {
    this.showPage(0)
  }

  async ratePositive(ev) {
    ev.preventDefault()
    this.onRatingSuccess(await this.post(ev.currentTarget.href), 1)
  }

  async rateNegative(ev) {
    ev.preventDefault()
    this.onRatingSuccess(await this.post(ev.currentTarget.href), 2)
  }

  onRatingSuccess(data, pageIndex) {
    if (!data || data.origin !== this.AJAX_LISTENERS.rate) return
    if (!data.rating_id) console.error('No rating ID returned')

    this.assignId(data.rating_id)

    this.showPage(pageIndex)
  }

  assignId(id) {
    this.retrievedRatingId = id
    this.ratingIdTargets.forEach(target => target.value = id)
  }

  hasMismatch() {
    if (this.ratingIdTarget.value !== this.retrievedRatingId) {
      this.ratingIdTarget.value = this.retrievedRatingId
      console.error(
        'There is a mismatch between the id retrieved and the id sent, the request has been aborted and the id reset.'
      )
      return true
    }
    return false
  }

  async submitComment(ev) {
    ev.preventDefault()
    const form = ev.currentTarget
    if (this.hasMismatch()) return

    // Allow users to submit an empty response, but prevent a db call
    const comment = form.elements.namedItem('comment')
    if (comment && !comment.value) {
      this.showPage(4)
      return
    }

    const data = await this.post(form.action, new FormData(form))
    if (!data || data.origin !== this.AJAX_LISTENERS.comment) return

    this.showPage(4)
  }

  async submitChoices(ev) {
    ev.preventDefault()
    const form = ev.currentTarget
    if (this.hasMismatch()) return

    // Allow users to submit an empty response, but prevent a db call
    const choices = form.elements.namedItem('choices')
    if (choices && !choices.value) {
      this.showPage(4)
      return
    }

    const data = await this.post(form.action, new FormData(form))
    if (!data || data.origin !== this.AJAX_LISTENERS.choices) return

    this.showPage(3)
  }

  // Resolves to the parsed JSON, or null for a non-2xx response (e.g. 409 when already rated)
  async post(url, body) {
    if (this.requestInFlight) return null
    this.requestInFlight = true

    try {
      const response = await fetch(url, {
        method: 'POST',
        body,
        headers: {
          Accept: 'application/json',
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]')?.content
        }
      })
      return response.ok ? response.json() : null
    } finally {
      this.requestInFlight = false
    }
  }

  showPage(index) {
    this.index = index
    this.pageTargets.forEach((el, i) => {
      el.classList.toggle('rating_page--current', index == i)
    })
  }
}
