import ApplicationController from "./application_controller";
import Rails from "@rails/ujs";

export default class extends ApplicationController {
  static targets = ["results", "form", "loadingBar"];

  connect() { }

  filter() {
    setTimeout(() => this.showLoadingBar(), 250);

    try {
      Rails.fire(this.formTarget, 'submit');
    } catch (err) {
      debugger;
      this.handleError(err);
    }
  }

  showLoadingBar() {
    this.loadingBarTarget.innerHTML = "<div class='govuk-body-m ncce-courses__loading-bar'>Loading...</div>";
  }

  handleResults(ev) {
    const [data, status, xhr] = ev.detail;
    this.resultsTarget.innerHTML = xhr.response;
  }
}
