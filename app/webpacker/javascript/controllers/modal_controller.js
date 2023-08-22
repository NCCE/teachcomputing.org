import ApplicationController from "./application_controller";

export default class extends ApplicationController {
  static targets = ['modal']

  toggle() {
    this.modalTarget.classList.toggle('ncce-modal--expanded')
  }
}
