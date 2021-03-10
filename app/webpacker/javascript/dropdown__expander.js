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
	// Get all the <h2> headings
	const headings = document.querySelectorAll('.' + className)
	let menuParent = null

	Array.prototype.forEach.call(headings, function iterateHeadings(heading) {
		heading.classList.add(headingToggleClass)

		// Assign the list element
		let btn = heading

		const toggleMenu = event => {
			if (event.key && event.key !== 'Tab') return;
			debugger

			if (event.currentTarget != menuParent) {
				let expanded = btn.getAttribute('aria-expanded') === 'true' || false
				btn.setAttribute('aria-expanded', !expanded)
	
				heading.classList.toggle(headingToggleClass)
				// Switch the content's visibility
				heading.children[1].classList.toggle(sectionToggleClass)
				menuParent = event.currentTarget
			} else {
				menuParent = event.currentTarget
			}
		}

		btn.onclick = toggleMenu
		btn.onmouseover = toggleMenu
		btn.onmouseout = toggleMenu
		btn.onkeyup = toggleMenu
	})
}



ready(function () {
	initialiseSections('dropdown__expander')
	// When we can reload and scroll, re-introduce
	// initialiseStickyFilterBar()
})

