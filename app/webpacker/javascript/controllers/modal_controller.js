import ApplicationController from "./application_controller";

export default class extends ApplicationController {
  static values = { confirm: Boolean }
  static targets = ['modal', 'confirmation']

  connect() {
    this.onKeyDown = this.onKeyDown.bind(this)
    this.onClick = this.onClick.bind(this)
    this.toggle = this.toggle.bind(this)

    document.body.addEventListener("keydown", this.onKeyDown)
    this.modalTarget.addEventListener("click", this.onClick)
    this.element.addEventListener("toggle", this.toggle)
  }

  disconnect() {
    document.body.removeEventListener("keydown", this.onKeyDown)
    this.modalTarget.removeEventListener("click", this.onClick)
    this.element.removeEventListener("toggle", this.toggle)
  }

  toggle() {
    this.modalTarget.classList.toggle('ncce-modal--expanded')
  }

  // if we are toggling on->off and we have a confirmation modal, show that. otherwise
  // toggle as normal.
  maybeToggle() {
    if (this.modalTarget.classList.contains("ncce-modal--expanded") && this.hasConfirmationTarget) {
      const confirmationModal = this.confirmationTarget.querySelector("[data-controller='modal']")
      confirmationModal.dispatchEvent(new CustomEvent("toggle", { }))
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
}
