import { Controller } from "stimulus"
import flatpickr from "flatpickr"

export default class extends Controller {
  static values = { options: Object }
  static targets = ['input']

  connect() {
    const options = {
      // if we are in range mode, we fire a change event just after selecting
      // the first input. this may be undesirable in cases where we only want
      // to update only after a completed beginning-end selection. to workaround
      // this, we fire a changeRange event when the selection is complete.
      onChange: (selectedDates, _dateStr, _instance) => {
        if (selectedDates.length == 1) return

        this.inputTarget.dispatchEvent(new CustomEvent("changeRange", {
          bubbles: true,
        }))
      },
      ...this.optionsValue,
    }
    this.flatpickr = flatpickr(this.inputTarget, options)
  }

  clear() {
    this.flatpickr.clear();
  }

  disconnect() {
    this.flatpickr.destroy()
  }
}
