import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  handleError = (error) => {
    const context = {
      controller: this.identifier,
    };
    this.application.handleError(
      error,
      `Error in controller: ${this.identifier}`,
      context
    );
  };
}
