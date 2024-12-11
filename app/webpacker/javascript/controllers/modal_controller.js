import ApplicationController from "./application_controller";

export default class extends ApplicationController {
  // even if we have a confirmationTarget, we may still want to not show the
  // confirmation modal. for example you only want to show a "save changes?"
  // confirmation modal if there are any changes. when this value is false,
  // it will prevent the confirmation modal from appearing.
  // static values = { confirm: { type: Boolean, default: false } }
  static values = { confirm: Boolean, modalId:String }

  static targets = ['modal', 'confirmation', 'topFocus', 'bottomFocus']

  connect() {
    this.onKeyDown = this.onKeyDown.bind(this)
    this.onClick = this.onClick.bind(this)
    this.toggle = this.toggle.bind(this)
    this.jumpToTop = this.jumpToTop.bind(this)

    document.body.addEventListener("keydown", this.onKeyDown)
    this.modalTarget.addEventListener("click", this.onClick)
    this.element.addEventListener("toggle", this.toggle)

    this.bottomFocusTarget.addEventListener("focus", this.jumpToTop)
    this.topFocusTarget.addEventListener("focus", this.jumpToTop)
  }

  disconnect() {
    document.body.removeEventListener("keydown", this.onKeyDown)
    this.modalTarget.removeEventListener("click", this.onClick)
    this.element.removeEventListener("toggle", this.toggle)
    this.bottomFocusTarget.removeEventListener("focus", this.jumpToTop)
    this.topFocusTarget.removeEventListener("focus", this.jumpToTop)
  }

  // keep focus within the modal when tabbing through elements
  jumpToTop() {
    document.getElementById(this.modalIdValue).focus()
  }

  toggle() {
    this.modalTarget.classList.toggle('ncce-modal--expanded')

    // if we are opening the modal, we no longer want to be focussed on stuff
    // behind it.
    const focusedElement = document.activeElement
    if (focusedElement) focusedElement.blur()
  }

  // if we are toggling on->off and we have a confirmation modal, show that. otherwise
  // toggle as normal.
  maybeToggle() {
    const expanded = this.modalTarget.classList.contains("ncce-modal--expanded")
    const confirmEnabled = this.hasConfirmationTarget && this.confirmValue
    if (expanded && confirmEnabled) {
      const confirmationModal = this.confirmationTarget.querySelector("[data-controller='modal']")
      confirmationModal.dispatchEvent(new CustomEvent("toggle", {}))
      return
    }

    this.toggle()
  }

  // we have multiple active modals, toggle them all
  cascade() {
    this.modalTarget.dispatchEvent(new CustomEvent("toggle", { bubbles: true }))
  }

  onClick(event) {
    if (event.target.classList.contains("ncce-modal--expanded")) {
      event.stopPropagation()
      this.maybeToggle()
    }
  }

  // we pressed escape, and we could either be focussed on the modal or not. find the modal
  // with the highest z-index and toggle it
  onKeyDown(event) {
    const escaping = event.key === "Escape"
    const expanded = this.modalTarget.classList.contains("ncce-modal--expanded")
    if (!(escaping && expanded)) return

    const z = (element) => Number(element.style.getPropertyValue("--z-index"))
    const topmost =
      Array.from(document.querySelectorAll(".ncce-modal--expanded"))
      .reduce((acc, x) =>  z(x) > z(acc) ? x : acc)

    if (topmost === this.modalTarget) {
      event.stopImmediatePropagation()
      this.maybeToggle()
    }
  }

  openWithText({detail: {content}}){
    console.log(content);
    this.toggle();
  }
}
