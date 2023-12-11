import ApplicationController from "../../webpacker/javascript/controllers/application_controller";

export default class extends ApplicationController {
  static targets = ['input']

  connect() {

  }

  click() {
    const urlParams = new URLSearchParams(window.location.search)
    urlParams.set('q', this.inputTarget.value)
    window.location.href = `search?${urlParams.toString()}`
  }
}
