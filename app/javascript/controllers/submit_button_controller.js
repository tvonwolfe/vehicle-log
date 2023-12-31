import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["submit"];
  static values = { clickedText: String };

  clicked() {
    const element = this.submitTarget;
    element.value = this.clickedTextValue;
    element.classList.add('button-disabled');
    element.classList.remove('button-enabled');
  }
}
