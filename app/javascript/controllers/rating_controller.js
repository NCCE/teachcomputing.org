import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["page"];

  initialize() {
    this.showPage(0);
  }

  onRatingSuccess(ev) {
    console.log('1');
    this.showPage(1);
  }

  onCommentSuccess(ev) {
    console.log('2');
    this.showPage(2);
  }

  showPage(index) {
    this.index = index;
    this.pageTargets.forEach((el, i) => {
      el.classList.toggle("page--current", index == i);
    });
  }
}
