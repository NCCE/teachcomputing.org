import ApplicationController from "./application_controller";

export default class extends ApplicationController {
  static targets = ['list', 'toggler']

  toggle() {
    this.listTarget.classList.toggle('community-activity-list--hidden')
    this.togglerTarget.classList.toggle('community-activity-list--toggle-down')
  }
}
