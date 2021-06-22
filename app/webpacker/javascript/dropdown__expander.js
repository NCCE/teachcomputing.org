import { onPageLoad } from './utilities/loaders'

function initialiseSections(className) {
  const menuItemToggleClass = className + '--closed'
  const sectionToggleClass = className + '-section--visible'
  const menuItems = document.querySelectorAll('.' + className) // Get all the <h2> headings

  const closeMenu = (menuItem) => {
    if (!menuItem) return
    menuItem.setAttribute('aria-expanded', 'false')
    menuItem.classList.add(menuItemToggleClass)
    menuItem.children[1].classList.remove(sectionToggleClass)
    menuItem.blur()
  }

  const openMenu = (menuItem) => {
    if (!menuItem) return
    menuItem.setAttribute('aria-expanded', 'true')
    menuItem.classList.remove(menuItemToggleClass)
    menuItem.children[1].classList.add(sectionToggleClass)
  }

  menuItems.forEach((menuItem) => {
    menuItem.classList.add(menuItemToggleClass)

    const subMenuItems = menuItem.children[1].children
    const lastSubMenuItem = subMenuItems[subMenuItems.length - 1]

    const toggleTabbedMenu = (event) => {
      const { key, srcElement } = event
      if (key !== 'Tab') return
      if (srcElement.innerText == lastSubMenuItem.innerText) {
        closeMenu(menuItem)
      } else {
        openMenu(menuItem)
      }
    }

    const toggleMenu = (event) => {
      let isTouch = false
      if (
        'ontouchstart' in window ||
        navigator.maxTouchPoints > 0 ||
        navigator.msMaxTouchPoints > 0
      ) {
        /* browser with either Touch Events of Pointer Events running on touch-capable device */
        isTouch = true
      }

      const isDesktop = window.matchMedia('(min-width: 769px)').matches
      if (!isTouch && event.type == 'click') return

      if (!isDesktop && ['mouseover', 'mouseout'].includes(event.type)) return

      menuItems.forEach((item) => {
        if (menuItem !== item) {
          closeMenu(item)
        }
      })

      if (!menuItem.classList.contains(menuItemToggleClass)) {
        closeMenu(menuItem)
      } else {
        openMenu(menuItem)
      }
    }

    const toggleExpanded = (event) => {
      let isTouch = false
      if (
        'ontouchstart' in window ||
        navigator.maxTouchPoints > 0 ||
        navigator.msMaxTouchPoints > 0
      ) {
        /* browser with either Touch Events of Pointer Events running on touch-capable device */
        isTouch = true
      }

      const isDesktop = window.matchMedia('(min-width: 769px)').matches

      if (isTouch && ['mouseover', 'mouseout'].includes(event.type)) return

      if (menuItem.getAttribute('aria-expanded') == 'true') {
        menuItem.setAttribute('aria-expanded', 'false')
      } else {
        menuItem.setAttribute('aria-expanded', 'true')
      }
    }

    menuItem.addEventListener('mouseover', toggleExpanded)
    menuItem.addEventListener('mouseout', toggleExpanded)
    menuItem.addEventListener('click', toggleMenu)
    menuItem.addEventListener('keydown', toggleTabbedMenu)
  })

  window.addEventListener('resize', () => {
    menuItems.forEach((menuItem) => {
      setTimeout(() => closeMenu(menuItem), 200)
    })
  })
}

onPageLoad(() => {
  initialiseSections('dropdown__expander')
})
