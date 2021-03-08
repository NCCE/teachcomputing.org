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
	Array.prototype.forEach.call(headings, function iterateHeadings(heading) {

		// heading.children[1].classList.add(sectionToggleClass)

		heading.classList.add(headingToggleClass)

		// Assign the list element
		let btn = heading

		btn.onclick = function btnOnClick() {
			// Cast the state as a boolean
			let expanded = btn.getAttribute('aria-expanded') === 'true' || false

			heading.classList.toggle(headingToggleClass)
			console.log("click")

			// Switch the state
			btn.setAttribute('aria-expanded', !expanded)
			// Switch the content's visibility
			heading.children[1].classList.toggle(sectionToggleClass)
		}
	})
}



ready(function () {
	initialiseSections('dropdown__expander')
	// When we can reload and scroll, re-introduce
	// initialiseStickyFilterBar()
})

