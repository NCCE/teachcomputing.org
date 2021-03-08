import { Controller } from "stimulus";

export default class extends Controller {
  AJAX_LISTENERS = { rate: 'rate', comment: 'comment' }
  static targets = ["page", "ratingId"];
  clearText = true;
  retrievedRatingId = '';

  initialize() {
    this.showPage(0);
  }

  onRatingSuccess(ev) {
    const { origin, rating_id } = ev.detail[0];
    if (origin !== this.AJAX_LISTENERS.rate) return;

    if (!rating_id) console.error("No rating ID returned");
    this.retrievedRatingId = rating_id;
    this.ratingIdTarget.value = rating_id;

    this.showPage(1);
  }

  onCommentBeforeSend(ev) {
    if (this.ratingIdTarget.value !== this.retrievedRatingId) {
      this.preventFormSubmission(ev);
      this.ratingIdTarget.value = this.retrievedRatingId;
      console.error("There is a mismatch between the id retrieved and the id sent, the request has been aborted and the id reset.");
    }

    // Allow users to submit an empty response, but prevent a db call
    const comment = ev.currentTarget.elements.namedItem("comment");
    if (comment && !comment.value) {
      this.preventFormSubmission(ev);
      this.showPage(2);
    }
  }

  onCommentSuccess(ev) {
    const { origin } = ev.detail[0];
    if (origin !== this.AJAX_LISTENERS.comment) return;

    this.showPage(2);
  }

  showPage(index) {
    this.index = index;
    this.pageTargets.forEach((el, i) => {
      el.classList.toggle("rating_page--current", index == i);
    });
  }

  preventFormSubmission(ev) {
    ev.preventDefault();
    ev.stopImmediatePropagation();
  }
}
