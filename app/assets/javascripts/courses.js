function ready(fn) {
  if (document.attachEvent ? document.readyState === "complete" : document.readyState !== "loading") {
    fn();
  } else {
    document.addEventListener('DOMContentLoaded', fn);
  }
}

function initialiseSections(className) {
  const headingToggleClass = className + '--closed'
  const sectionToggleClass = className + '-section--closed'
  // Get all the <h2> headings
  const headings = document.querySelectorAll('.' + className)
  Array.prototype.forEach.call(headings, function iterateHeadings(heading) {
    // We only have a single node to pull out here the next thing.
    let contents = heading.nextElementSibling
    contents.parentNode.removeChild(contents)

    // Create a wrapper element for `contents` and hide it
    let wrapper = document.createElement('div')
    wrapper.classList.add(sectionToggleClass)

    // Add each element of `contents` to `wrapper`
    wrapper.appendChild(contents)

    // Add the wrapped content back into the DOM
    // after the heading
    heading.parentNode.insertBefore(wrapper, heading.nextElementSibling)

    heading.classList.add(headingToggleClass)

    // Assign the button
    let btn = heading.querySelector('button')

    btn.onclick = function btnOnClick() {
      // Cast the state as a boolean
      let expanded = btn.getAttribute('aria-expanded') === 'true' || false

      heading.classList.toggle(headingToggleClass)

      // Switch the state
      btn.setAttribute('aria-expanded', !expanded)
      // Switch the content's visibility
      wrapper.classList.toggle(sectionToggleClass)
    }
  })
}

function initialiseStickyFilterBar() {
  const className = 'ncce-courses__filter-container'
  const filterContainer = document.querySelector('.' + className)
  let filterTop = filterContainer.offsetTop
  let sticky = false

  document.onscroll = function documentOnScroll(e) {
    const top = e.target.scrollingElement.scrollTop
    if (!sticky) {
      filterTop = filterContainer.offsetTop
      if (top > filterTop) {
        filterContainer.classList.add(className + '--sticky')
        sticky = true
      }
    } else if (top < filterTop) {
      filterContainer.classList.remove(className + '--sticky')
      sticky = false
    }
  }

}

ready(function () {
  initialiseSections('ncce-courses__locations')
  initialiseSections('ncce-courses__filter-mobile-heading')
  // When we can reload and scroll, re-introduce
  // initialiseStickyFilterBar()
})
