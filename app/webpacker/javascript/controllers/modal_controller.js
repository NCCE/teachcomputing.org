import ApplicationController from "./application_controller";

export default class extends ApplicationController {
  static targets = ['modal']

  connect() {
    console.log('hello world')
  }

  toggle() {
    this.modalTarget.classList.toggle('ncce-modal--expanded')
  }
}
