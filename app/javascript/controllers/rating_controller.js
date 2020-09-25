import { Controller } from "stimulus";

export default class extends Controller {
  AJAX_LISTENERS = { rate: 'rate', comment: 'comment' }
  static targets = ["page"];
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

    this.showPage(1);
  }

  onCommentSuccess(ev) {
    const { origin } = ev.detail[0];
    if (origin !== this.AJAX_LISTENERS.comment) return;

    this.showPage(2);
  }

  onTextAreaFocus(ev) {
    if (this.clearText) {
      ev.target.value = '';
      this.clearText = false;
    }
  }

  showPage(index) {
    this.index = index;
    this.pageTargets.forEach((el, i) => {
      el.classList.toggle("rating_page--current", index == i);
    });
  }
}
