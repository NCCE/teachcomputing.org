import ApplicationController from "./application_controller";
import Rails from "@rails/ujs";

export default class extends ApplicationController {
  static targets = [
    'jsEnabled',
    'results',
    'form',
    'loadingBar',
    'courseList',
    'clearFilters',
    'resultsCount',
    'filterForm',
    'filterFormToggle',
    'filterCount',
    'viewResultsCount'
  ];
  menuClass = '';
  filterCount = 0;
  defaultResultsCountString = '';
  defaultViewResultsCountString = '';
  hiddenClass = '';
  openModifier = '';
  intervalId = null;

  initialize() {
    this.menuClass = 'ncce-courses__filter-form-toggle';
    this.defaultResultsCountString = 'Showing 0 results';
    this.defaultViewResultsCountString = 'View 0 results';
    this.hiddenClass = 'hidden';
    this.openModifier = '--open';
  }

  filter(ev) {
    this.toggleActiveSelect(ev);
    this.toggleLoadingBar();

    try {
      this.resultsTarget.scrollIntoView(true);
      Object.values(ev.currentTarget.form).find(field => field.name == 'js_enabled').value = true;
      Rails.fire(this.formTarget, 'submit');
    } catch (err) {
      clearInterval(this.intervalId);
      this.loadingBarTarget.innerText = "An error has occurred, please refresh the page and try again.";
      this.handleError(err);
    }
  }

  toggleActiveSelect(ev) {
    const { currentTarget } = ev;
    if (currentTarget.selectedIndex == 0) {
      currentTarget.classList.remove('filter--active');
      currentTarget.blur();
      this.filterCount--;
    } else {
      currentTarget.classList.add('filter--active');
      this.filterCount++;
    }

    this.updateFilterCount();
  }

  updateFilterCount() {
    this.filterCountTarget.innerText = `${this.filterCount} ${this.filterCount == 1 ? 'filter' : 'filters'} applied`;
  }

  toggleLoadingBar() {
    const loadingBar = this.loadingBarTarget.classList;
    const courseList = this.courseListTarget.classList;

    this.animateLoadingBar();

    this.resultsCountTarget.innerText = this.defaultResultsCountString;
    this.viewResultsCountTarget.innerText = this.defaultViewResultsCountString;

    loadingBar.toggle(this.hiddenClass);
    courseList.toggle(this.hiddenClass);
  }

  animateLoadingBar() {
    let dots = 3;

    this.intervalId = setInterval(() => {
      if (dots < 3) {
        this.loadingBarTarget.innerText += '.';
        dots++;
      } else {
        clearInterval(this.intervalId);
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

    // Set the count on the view results button on mobile
    this.viewResultsCountTarget.innerText =
      this.resultsCountTarget.innerText.replace('Showing', 'View');

    if (clearFilters.contains(this.hiddenClass)) {
      clearFilters.remove(this.hiddenClass);
    }
  }

  clearFilters() {
    this.toggleLoadingBar();
    this.resultsCountTarget.innerText = this.defaultResultsCountString;
  }

  openFilterForm() {
    const formClasses = this.filterFormTarget.classList;
    const menuClasses = this.filterFormToggleTarget.classList;
    menuClasses.replace(this.menuClass, `${this.menuClass}${this.openModifier}`);
    formClasses.remove(this.hiddenClass);
  }

  closeFilterForm() {
    const formClasses = this.filterFormTarget.classList;
    const menuClasses = this.filterFormToggleTarget.classList;
    menuClasses.replace(`${this.menuClass}${this.openModifier}`, this.menuClass);
    formClasses.add(this.hiddenClass);
    this.resultsTarget.scrollIntoView(true);
  }

  openFilterFormOnDesktop() {
    if (window.matchMedia('(max-width: 669px)').matches) return;
    this.openFilterForm();
  }

  toggleFilterForm() {
    const formClasses = this.filterFormTarget.classList;
    if (!formClasses.contains(this.hiddenClass)) {
      this.closeFilterForm();
    } else {
      this.openFilterForm();
    }
  }
}
