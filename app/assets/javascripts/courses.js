function ready(fn) {
  if (document.attachEvent ? document.readyState === "complete" : document.readyState !== "loading"){
    fn();
  } else {
    document.addEventListener('DOMContentLoaded', fn);
  }
}

function initialiseSections() {
  const headingToggleClass = 'ncce-courses__locations--closed'
  // Get all the <h2> headings
  const headings = document.querySelectorAll('.ncce-courses__locations')
  Array.prototype.forEach.call(headings, heading => {
    // We only have a single node to pull out here the next thing.
    let contents = heading.nextElementSibling
    contents.parentNode.removeChild(contents)

    // Create a wrapper element for `contents` and hide it
    let wrapper = document.createElement('div')
    wrapper.hidden = true

    // Add each element of `contents` to `wrapper`
    wrapper.appendChild(contents)

    // Add the wrapped content back into the DOM
    // after the heading
    heading.parentNode.insertBefore(wrapper, heading.nextElementSibling)

    heading.classList.add(headingToggleClass)

    // Assign the button
    let btn = heading.querySelector('button')

    btn.onclick = () => {
      // Cast the state as a boolean
      let expanded = btn.getAttribute('aria-expanded') === 'true' || false

    heading.classList.toggle(headingToggleClass)

      // Switch the state
      btn.setAttribute('aria-expanded', !expanded)
      // Switch the content's visibility
      wrapper.hidden = expanded
    }
  })
}


function initialiseFilter() {
  const applyButton = document.querySelector('.js-course-filter-button')
  const filterSelects = document.querySelectorAll('.js-course-filter-select')
  const filterForm = document.querySelector('.js-course-filter-form')

  Array.prototype.forEach.call(filterSelects, filterSelect => {
    filterSelect.onchange = (event) => {
      console.log('change! ', event.target.value);
      filterForm.submit();
    }
  })

  applyButton.style.display = 'none'

}

ready(function() {
  initialiseSections()
  initialiseFilter()
})
