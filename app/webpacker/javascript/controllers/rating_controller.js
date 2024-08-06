import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  AJAX_LISTENERS = { rate: 'rate', choices: 'choices', comment: 'comment' }
  static targets = ['page', 'ratingId']
  clearText = true
  retrievedRatingId = ''

  initialize() {
    this.showPage(0)
  }

  onRatingSuccessPositive(ev) {
    const { origin, rating_id } = ev.detail[0]
    if (origin !== this.AJAX_LISTENERS.rate) return
    if (!rating_id) console.error('No rating ID returned')

    this.assignId(rating_id)

    this.showPage(1)
  }

  onRatingSuccessNegative(ev) {
    const { origin, rating_id } = ev.detail[0]
    if (origin !== this.AJAX_LISTENERS.rate) return
    if (!rating_id) console.error('No rating ID returned')

    this.assignId(rating_id)

    this.showPage(2)
  }

  assignId(id) {
    this.retrievedRatingId = id
    this.ratingIdTargets.forEach(target => target.value = id)
  }

  checkForMismatch(ev) {
    if (this.ratingIdTarget.value !== this.retrievedRatingId) {
      this.preventFormSubmission(ev)
      this.ratingIdTarget.value = this.retrievedRatingId
      console.error(
        'There is a mismatch between the id retrieved and the id sent, the request has been aborted and the id reset.'
      )
    }
  }

  onCommentBeforeSend(ev) {
    this.checkForMismatch(ev)

    // Allow users to submit an empty response, but prevent a db call
    const comment = ev.currentTarget.elements.namedItem('comment')
    if (comment && !comment.value) {
      this.preventFormSubmission(ev)
      this.showPage(5)
    }
  }

  onChoicesBeforeSend(ev) {
    this.checkForMismatch(ev)

    // Allow users to submit an empty response, but prevent a db call
    const choices = ev.currentTarget.elements.namedItem('choices')
    if (choices && !choices.value) {
      this.preventFormSubmission(ev)
      this.showPage(4)
    }
  }

  onChoicesSuccess(ev) {
    const { origin } = ev.detail[0]
    if (origin !== this.AJAX_LISTENERS.choices) return

    // Allows us to alter comment section text based on like or dislike
    const pageIndex = this.index
    this.showPage(3)
  }

  onCommentSuccess(ev) {
    const { origin } = ev.detail[0]
    if (origin !== this.AJAX_LISTENERS.comment) return

    this.showPage(4)
  }

  showPage(index) {
    this.index = index
    this.pageTargets.forEach((el, i) => {
      el.classList.toggle('rating_page--current', index == i)
    })
  }

  preventFormSubmission(ev) {
    ev.preventDefault()
    ev.stopImmediatePropagation()
  }
}
