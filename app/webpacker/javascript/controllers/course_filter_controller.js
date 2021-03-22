import ApplicationController from "./application_controller";
import Rails from "@rails/ujs";

export default class extends ApplicationController {
  static targets = ['results', 'form', 'loadingBar', 'courseList', 'clearFilters', 'resultsCount'];
  intervalId = null;

  initialize() {
    this.clearFiltersTarget.addEventListener('click', () => {
      this.toggleLoadingBar();
      this.resetResultsCount(this.resultsCountTarget)
    });
  }

  filter(ev) {
    this.toggleActiveSelect(ev);
    this.toggleLoadingBar();

    try {
      this.resultsTarget.scrollIntoView(true);
      Rails.fire(this.formTarget, 'submit');
    } catch (err) {
      this.handleError(err);
    }
  }

  resetResultsCount(target) {
    target.innerText = 'Showing 0 results'
  }

  toggleActiveSelect(ev) {
    const { currentTarget } = ev;
    if (currentTarget.selectedIndex == 0) {
      currentTarget.classList.remove('ncce-select--filters--active');
      currentTarget.blur();
    } else {
      currentTarget.classList.add('ncce-select--filters--active');
    }
  }

  toggleLoadingBar() {
    const loadingBar = this.loadingBarTarget.classList;
    const courseList = this.courseListTarget.classList;

    this.resetResultsCount(this.resultsCountTarget);
    this.animateLoadingBar();

    loadingBar.toggle('hidden');
    courseList.toggle('hidden');
  }

  animateLoadingBar() {
    let dots = 3;
    if (this.intervalId) clearInterval(this.intervalId);

    this.intervalId = setInterval(() => {
      if (dots < 3) {
        this.loadingBarTarget.innerText += '.';
        dots++;
      } else {
        this.loadingBarTarget.innerText = 'Loading'
        dots = 0;
      }
    }, 750);
  }

  handleResults(ev) {
    const [, , xhr] = ev.detail;
    const clearFilters = this.clearFiltersTarget.classList;

    this.toggleLoadingBar();
    this.resultsTarget.innerHTML = xhr.response;

    if (clearFilters.contains('hidden')) {
      clearFilters.remove('hidden');
    }
  }
}
