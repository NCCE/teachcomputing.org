function ready(fn) {
  if (document.attachEvent ? document.readyState === "complete" : document.readyState !== "loading") {
    fn();
  } else {
    document.addEventListener('DOMContentLoaded', fn);
  }
}

function initialiseSections(className) {
  const headingToggleClass = className + '--closed'
  const sectionToggleClass = className + '-section--visible'
  const headings = document.querySelectorAll('.' + className) // Get all the <h2> headings

  Array.prototype.forEach.call(headings, (heading) => {
    heading.classList.add(headingToggleClass)

    // Assign the list element
    const btn = heading
    const items = btn.children[1].children
    const lastItem = items[items.length - 1]

    const openMenu = (event) => {
      btn.setAttribute('aria-expanded', 'true')
      btn.classList.remove(headingToggleClass)
      btn.children[1].classList.add(sectionToggleClass)
    }

    const closeMenu = (event) => {
      btn.setAttribute('aria-expanded', 'false')
      btn.classList.add(headingToggleClass)
      btn.children[1].classList.remove(sectionToggleClass)
    }

    const tabOpen = event => {
      if (event.key && event.key !== 'Tab') return;
      openMenu(event)
    }

    const tabClose = event => {
      if (event.key && event.key !== 'Tab') return;
      if (event.srcElement.innerText == lastItem.innerText) {
        closeMenu(event)
      }
    }

    const toggleMenu = (event) => {
      if (event.currentTarget.getAttribute('aria-expanded') == 'true') {
        closeMenu(event)
      } else {
        openMenu(event)
      }
    }

    btn.onclick = toggleMenu // TODO should only happen on mobile & styling goes odd
    btn.onmouseover = openMenu
    btn.onmouseout = closeMenu

    btn.addEventListener('focusin', tabOpen)
    btn.addEventListener('focusout', tabClose)
  })
}



ready(function () {
  initialiseSections('dropdown__expander')
  // When we can reload and scroll, re-introduce
  // initialiseStickyFilterBar()
})

