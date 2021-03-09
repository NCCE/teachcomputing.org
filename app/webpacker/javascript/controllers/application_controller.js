import { Controller } from "stimulus";

export default class extends Controller {
  handleError = (error) => {
    const context = {
      controller: this.identifier,
      user_id: this.userId,
    };
    this.application.handleError(
      error,
      `Error in controller: ${this.identifier}`,
      context
    );
  };

  get userId() {
    return this.metaValue("user_id");
  }
}
