function ready(fn) {
  if (document.attachEvent ? document.readyState === "complete" : document.readyState !== "loading") {
    fn();
  } else {
    document.addEventListener('DOMContentLoaded', fn);
  }
}

function initialiseSections(className) {
  const menuItemToggleClass = className + '--closed'
  const sectionToggleClass = className + '-section--visible'
  const menuItems = document.querySelectorAll('.' + className) // Get all the <h2> headings

  const closeMenu = (menuItem) => {
    menuItem.setAttribute('aria-expanded', 'false')
    menuItem.classList.add(menuItemToggleClass)
    menuItem.children[1].classList.remove(sectionToggleClass)
  }

  const openMenu = (menuItem) => {
    menuItem.setAttribute('aria-expanded', 'true')
    menuItem.classList.remove(menuItemToggleClass)
    menuItem.children[1].classList.add(sectionToggleClass)
  }

  menuItems.forEach(menuItem => {
    if (!menuItem.classList.contains(menuItemToggleClass)) {
      menuItem.classList.add(menuItemToggleClass)
    }

    const subMenuItems = menuItem.children[1].children
    const lastSubMenuItem = subMenuItems[subMenuItems.length - 1]

    const toggleTabbedMenu = event => {
      const { key, srcElement } = event
      if (key !== 'Tab') return
      if (srcElement.innerText == lastSubMenuItem.innerText) {
        closeMenu(menuItem)
      } else {
        openMenu(menuItem)
      }
    }

    const toggleMenu = event => {
      // Prevent mouse over & out events firing on mobile
      const mouseEvents = ['mouseout', 'mouseover']
      if (!window.matchMedia('(min-width: 770px)').matches
        && mouseEvents.includes(event.type)) {
        return
      }

      if (menuItem.classList.contains(menuItemToggleClass)) {
        openMenu(menuItem)
      } else {
        closeMenu(menuItem)
      }
    }

    menuItem.addEventListener('mouseover', toggleMenu)
    menuItem.addEventListener('mouseout', toggleMenu)
    menuItem.addEventListener('click', toggleMenu)
    menuItem.addEventListener('keydown', toggleTabbedMenu)
  })

  const closeAllMenus = () => menuItems.forEach(menuItem => closeMenu(menuItem))
  window.addEventListener('resize', closeAllMenus)
  window.addEventListener('keydown', event => {
    if (event.key == 'Escape') closeAllMenus()
  })
}

ready(function () {
  initialiseSections('dropdown__expander')
})

