import { Controller } from 'stimulus'

export default class extends Controller {
  AJAX_LISTENERS = { rate: 'rate', choices: 'choices', comment: 'comment' }
  static targets = ['page', 'ratingId', 'ratingIdChoices']
  clearText = true
  retrievedRatingId = ''

  initialize() {
    this.showPage(0)
  }

  onRatingSuccessPositive(ev) {
    const { origin, rating_id } = ev.detail[0]
    if (origin !== this.AJAX_LISTENERS.rate) return

    if (!rating_id) console.error('No rating ID returned')
    this.retrievedRatingId = rating_id
    this.ratingIdTarget.value = rating_id

    this.showPage(1)
  }

  onRatingSuccessNegative(ev) {
    const { origin, rating_id } = ev.detail[0]
    if (origin !== this.AJAX_LISTENERS.rate) return

    if (!rating_id) console.error('No rating ID returned')
    this.retrievedRatingId = rating_id
    this.ratingIdChoicesTarget.value = rating_id

    this.showPage(3)
  }

  checkForMismatch(ev, target) {
    if (this[target].value !== this.retrievedRatingId) {
      this.preventFormSubmission(ev)
      this[target].value = this.retrievedRatingId
      console.error(
        'There is a mismatch between the id retrieved and the id sent, the request has been aborted and the id reset.'
      )
    }
  }

  onCommentBeforeSend(ev) {
    this.checkForMismatch(ev, 'ratingIdTarget')

    // Allow users to submit an empty response, but prevent a db call
    const comment = ev.currentTarget.elements.namedItem('comment')
    if (comment && !comment.value) {
      this.preventFormSubmission(ev)
      this.showPage(5)
    }
  }

  onChoicesBeforeSend(ev) {
    this.checkForMismatch(ev, 'ratingIdChoicesTarget')

    // Allow users to submit an empty response, but prevent a db call
    const choices = ev.currentTarget.elements.namedItem('choices')
    if (choices && !choices.value) {
      this.preventFormSubmission(ev)
      this.showPage(5)
    }
  }

  onCommentSuccess(ev) {
    const { origin } = ev.detail[0]
    if (origin !== this.AJAX_LISTENERS.comment) return

    this.showPage(5)
  }

  onChoicesSuccess(ev) {
    debugger
    const { origin, rating_choice, rating_id } = ev.detail[0]
    if (origin !== this.AJAX_LISTENERS.choices) return
    this.showPage(4)
  }

  // onChoicesSuccessNegative() {
  //   this.showPage(5)
  // }

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
