import { onPageLoad } from './utilities/loaders'

function initialiseSections(className) {
  const headingToggleClass = className + '--closed'
  const sectionToggleClass = className + '-section--closed'

  // Get all the <h2> headings
  const headings = document.querySelectorAll('.' + className)
  headings.forEach(heading => {
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

    btn.onclick = () => {
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

onPageLoad(() => {
  initialiseSections('ncce-courses__locations')
  initialiseSections('ncce-courses__filter-mobile-heading')
})
