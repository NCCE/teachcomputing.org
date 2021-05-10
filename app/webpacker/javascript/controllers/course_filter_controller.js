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
    'resultsContainer',
    'hubMessage',
    'filterForm',
    'filterFormHeader',
    'filterFormToggle',
    'filterCount',
    'filterCount2',
    'viewResultsCount',
    'distanceFilter',
    'geocodedLocation',
    'geocodingError',
    'radiusSelect',
    'nationwideCourses',
    'showNationwideCourses',
    'hideNationwideCourses',
    'moreCourses'
  ];
  menuClass = '';
  filterCount = 0;
  defaultResultsCountString = '';
  defaultViewResultsCountString = '';
  hiddenClass = '';
  openModifier = '';
  intervalId = null;
  locationFiltering = false;

  initialize() {
    this.menuClass = 'ncce-courses__filter-form-toggle';
    this.defaultResultsCountString = 'Showing results';
    this.defaultViewResultsCountString = 'View results';
    this.hiddenClass = 'hidden';
    this.openModifier = '--open';

    this.openFilterFormOnDesktop();
  }

  filter(ev) {
    this.toggleLoadingBar();

    try {
      this.scrollToTop();
      Object.values(this.formTarget).find(field => field.name == 'js_enabled').value = true;
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

  scrollToFilters(ev) {
    ev.preventDefault();
    let scroll_target = document.getElementById('results-top');
    scroll_target.scrollIntoView(true);
    document.activeElement.blur();
  }

  toggleActiveSelect(ev) {
    const { currentTarget } = ev;
    const { options: { selectedIndex } } = currentTarget;

    if (selectedIndex == 0) {
      currentTarget.options[selectedIndex].removeAttribute('selected');
      currentTarget.classList.remove('filter--active');
      currentTarget.blur();
      this.filterCount--;
    } else {
      Object.values(currentTarget.options).forEach(option => option.removeAttribute('selected'));
      currentTarget.options[selectedIndex].setAttribute('selected', true);
      currentTarget.classList.add('filter--active');
      this.filterCount++;
    }
  }

  toggleActiveCheckbox(ev) {
    const { currentTarget } = ev;
    const checked = currentTarget.getAttribute('checked');
    if (checked) {
      currentTarget.removeAttribute('checked');
      currentTarget.blur();
      this.filterCount--;
    } else {
      currentTarget.setAttribute('checked', 'checked');
      this.filterCount++;
    }
  }

  addLocationFilter(ev) {
    if(this.locationFiltering === false) {
      this.filterCount++;
      this.locationFiltering = true;
    }
  }

  updateFilterCount() {
    if (this.filterCount > 0) {
      this.filterCountTarget.classList.remove(this.hiddenClass);
      this.filterCount2Target.classList.remove(this.hiddenClass);
    } else {
      this.filterCountTarget.classList.add(this.hiddenClass);
      this.filterCount2Target.classList.add(this.hiddenClass);
    }

    this.filterCountTarget.innerText = `${this.filterCount} ${this.filterCount == 1 ? 'filter' : 'filters'} applied`;
    this.filterCount2Target.innerText = `${this.filterCount} ${this.filterCount == 1 ? 'filter' : 'filters'} applied`;
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

    this.minHeightHack();
    this.animateLoadingBar();

    this.resultsCountTarget.innerText = this.defaultResultsCountString;
    this.viewResultsCountTarget.innerText = this.defaultViewResultsCountString;

    loadingBar.toggle(this.hiddenClass);
    courseList.toggle(this.hiddenClass);
  }

  showNationwideCourses() {
    this.nationwideCoursesTarget.classList.remove(this.hiddenClass);
    this.showNationwideCoursesTarget.classList.add(this.hiddenClass);
    this.hideNationwideCoursesTarget.classList.remove(this.hiddenClass);
  }

  hideNationwideCourses() {
    this.showNationwideCoursesTarget.classList.remove(this.hiddenClass);
    this.hideNationwideCoursesTarget.classList.add(this.hiddenClass);
    this.moreCoursesTarget.scrollIntoView(true);
    this.nationwideCoursesTarget.classList.add(this.hiddenClass);
  }

  /** This is to prevent some of the jumpiness on desktop as the page resizes */
  minHeightHack() {
    if (!this.isDesktop()) return;

    const minHeight = '1000px';
    if (this.resultsTarget.style.minHeight == minHeight) {
      this.resultsTarget.style.minHeight = 'initial';
    } else {
      this.resultsTarget.style.minHeight = minHeight;
    }
  }

  animateLoadingBar() {
    let dots = 3;

    clearInterval(this.intervalId);

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

    this.toggleLoadingBar();

    let res = JSON.parse(xhr.response)
    this.resultsTarget.innerHTML = res.results;

    if (res.location_search) {
      if(res.geocoded_successfully) {
        this.geocodedLocationTarget.innerText = res.geocoded_location;
        this.hideGeocodingError();
        this.showDistanceFilter();
      } else {
        this.hideDistanceFilter();
        this.showGeocodingError();
      }
    }
    // Set the count on the view results button on mobile
    this.viewResultsCountTarget.innerText =
      this.resultsCountTarget.innerText.replace('Showing', 'View');


    this.updateFilterCount();
    this.toggleClearFilter();
  }

  clearFilters() {
    this.toggleLoadingBar();
    this.resultsCountTarget.innerText = this.defaultResultsCountString;
    this.locationFiltering = false;
  }

  openFilterForm() {
    const menuClasses = this.filterFormToggleTarget.classList;
    menuClasses.replace(this.menuClass, `${this.menuClass}${this.openModifier}`);
    this.filterFormTarget.classList.remove(this.hiddenClass);
  }

  closeFilterForm() {
    const menuClasses = this.filterFormToggleTarget.classList;
    menuClasses.replace(`${this.menuClass}${this.openModifier}`, this.menuClass);
    this.filterFormTarget.classList.add(this.hiddenClass);
  }

  openFilterFormOnDesktop() {
    if (!this.isDesktop()) return;
    this.openFilterForm();
  }

  toggleFilterForm() {
    const formClasses = this.filterFormTarget.classList;
    if (!formClasses.contains(this.hiddenClass)) {
      this.closeFilterForm();
    } else {
      this.openFilterForm();
    }
    this.scrollToTop();
  }

  expandSearch(){
    let lastValue = this.radiusSelectTarget.options[this.radiusSelectTarget.options.length - 1].value;
    this.radiusSelectTarget.value = lastValue;
    this.filter();
  }

  showDistanceFilter() {
    const classes = this.distanceFilterTarget.classList;
    if (classes.contains(this.hiddenClass)) {
      this.distanceFilterTarget.classList.remove(this.hiddenClass);
    }
  }

  hideDistanceFilter() {
    const classes = this.distanceFilterTarget.classList;
    if (!classes.contains(this.hiddenClass)) {
      this.distanceFilterTarget.classList.add(this.hiddenClass);
    }
  }

  showGeocodingError() {
    const classes = this.geocodingErrorTarget.classList;
    if (classes.contains(this.hiddenClass)) {
      this.geocodingErrorTarget.classList.remove(this.hiddenClass);
    }
  }

  hideGeocodingError() {
    const classes = this.geocodingErrorTarget.classList;
    if (!classes.contains(this.hiddenClass)) {
      this.geocodingErrorTarget.classList.add(this.hiddenClass);
    }
  }

  isDesktop() {
    return window.matchMedia(`(min-width: 770px)`).matches;
  }

  isMenuOpen() {
    return !this.filterFormTarget.classList.contains(this.hiddenClass);
  }
}
