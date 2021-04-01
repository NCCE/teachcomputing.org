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
    'pageMask',
    'resultsCount',
    'resultsContainer',
    'hubMessage',
    'filterForm',
    'filterFormHeader',
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
  tabletWidth = 0;
  intervalId = null;

  initialize() {
    this.menuClass = 'ncce-courses__filter-form-toggle';
    this.defaultResultsCountString = 'Showing 0 results';
    this.defaultViewResultsCountString = 'View results';
    this.hiddenClass = 'hidden';
    this.openModifier = '--open';
    this.tabletWidth = 769;
  }

  connect() {
    this.addPageMaskOnMobile();
  }

  filter(ev) {
    this.toggleActiveSelect(ev);
    this.toggleLoadingBar();

    try {
      this.scrollToTop();
      Object.values(ev.currentTarget.form).find(field => field.name == 'js_enabled').value = true;
      Rails.fire(this.formTarget, 'submit');
    } catch (err) {
      clearInterval(this.intervalId);
      this.loadingBarTarget.innerText = "An error has occurred, please refresh the page and try again.";
      this.handleError(err);
    }
  }

  scrollToTop() {
    const scrollTarget = this.hasHubMessageTarget ? this.hubMessageTarget : this.resultsContainerTarget;
    scrollTarget.scrollIntoView(true);
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
  }

  updateFilterCount() {
    if (this.filterCount > 0) {
      this.filterCountTarget.classList.remove(this.hiddenClass);
    } else {
      this.filterCountTarget.classList.add(this.hiddenClass);
    }

    this.filterCountTarget.innerText = `${this.filterCount} ${this.filterCount == 1 ? 'filter' : 'filters'} applied`;
  }

  toggleClearFilter() {
    if (this.filterCount > 0) {
      this.clearFiltersTarget.classList.remove(this.hiddenClass);
    } else {
      this.clearFiltersTarget.classList.add(this.hiddenClass);
    }
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


    this.updateFilterCount();
    this.toggleClearFilter();
  }

  clearFilters() {
    this.toggleLoadingBar();
    this.resultsCountTarget.innerText = this.defaultResultsCountString;
  }

  openFilterForm() {
    const menuClasses = this.filterFormToggleTarget.classList;
    menuClasses.replace(this.menuClass, `${this.menuClass}${this.openModifier}`);
    this.filterFormTarget.classList.remove(this.hiddenClass);
    this.pageMaskTarget.classList.remove(this.hiddenClass);
  }

  closeFilterForm() {
    const menuClasses = this.filterFormToggleTarget.classList;
    menuClasses.replace(`${this.menuClass}${this.openModifier}`, this.menuClass);
    this.filterFormTarget.classList.add(this.hiddenClass);
    this.pageMaskTarget.classList.add(this.hiddenClass);
    this.scrollToTop();
  }

  addPageMaskOnMobile() {
    if (window.matchMedia(`(min-width: ${this.tabletWidth}px)`).matches) return;
    this.pageMaskTarget.classList.remove(this.hiddenClass);
  }

  removePageMaskOnDesktop() {
    if (window.matchMedia(`(max-width: ${this.tabletWidth}px)`).matches) return;
    this.pageMaskTarget.classList.add(this.hiddenClass);
  }

  openFilterFormOnDesktop() {
    if (window.matchMedia(`(max-width: ${this.tabletWidth}px)`).matches) return;
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
