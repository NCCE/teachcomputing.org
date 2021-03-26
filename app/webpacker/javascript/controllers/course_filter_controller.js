import ApplicationController from "./application_controller";
import Rails from "@rails/ujs";

export default class extends ApplicationController {
  static targets = [
    'results',
    'form',
    'loadingBar',
    'courseList',
    'clearFilters',
    'resultsCount',
    'filterForm',
    'filterFormToggle',
    'filterCount'
  ];
  intervalId = null;
  menuClass = null;
  filterCount = 0;

  connect() {
    this.menuClass = 'ncce-courses__filter-form-toggle';
  }

  filter(ev) {
    this.toggleActiveSelect(ev);
    this.toggleLoadingBar();

    try {
      // this.resultsTarget.scrollIntoView(true);
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
      this.filterCount--;
    } else {
      currentTarget.classList.add('ncce-select--filters--active');
      this.filterCount++;
    }

    this.updateFilterCount();
  }

  updateFilterCount() {
    this.filterCountTarget.innerText = `${this.filterCount} filters applied`;
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

  clearFilters() {
    this.toggleLoadingBar();
    this.resetResultsCount(this.resultsCountTarget);
  }

  openFilterForm() {
    const formClasses = this.filterFormTarget.classList;
    const menuClasses = this.filterFormToggleTarget.classList;
    menuClasses.replace(this.menuClass, `${this.menuClass}--open`);
    formClasses.remove('hidden');
  }

  closeFilterForm() {
    const formClasses = this.filterFormTarget.classList;
    const menuClasses = this.filterFormToggleTarget.classList;
    menuClasses.replace(`${this.menuClass}--open`, this.menuClass);
    formClasses.add('hidden');
  }

  openFilterFormOnDesktop() {
    if (window.matchMedia('(max-width: 669px)').matches) return;
    this.openFilterForm();
  }

  toggleFilterForm() {
    const formClasses = this.filterFormTarget.classList;
    if (!formClasses.contains('hidden')) {
      this.closeFilterForm();
    } else {
      this.openFilterForm();
    }
  }
}
