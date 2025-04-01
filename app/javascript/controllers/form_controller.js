import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["submit"];
  /**
   * @param {Event} event
   */
  submit(event) {
    this.submitTarget.classList.add("button-disabled");
  }
}
