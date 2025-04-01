import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["container", "input"];
  /**
   * @param {Event}
   */
  invalid(event) {
    event.preventDefault();

    this.validateField(this.inputTarget)
  }

  /**
   * @param {Event}
   */
  changed() {
    this.resetField(this.inputTarget);
  }

  /**
   * Check to see if the input field is valid. If not, adds error class to the 
   * input element.
   * @param {HTMLInputElement} element - the input element to validate
   */
  validateField(element) {
    if (element.validity.valid) return true;

    element.classList.add("input-outline-error");
    element.classList.remove("input-outline-normal");
    this.showErrorMessage(element.validationMessage);

    return false;
  }

  /**
   * Remove any validation classes and error messages.
   * @param {HTMLInputElement} element - the input element to validate
   */
  resetField(element) {
    element.classList.add("input-outline-normal");
    element.classList.remove("input-outline-error");

    this.clearErrorMessage();
  }

  /**
   * @param {String} message - error message to display
   */
  showErrorMessage(message) {
    this.clearErrorMessage();

    const errorMessage = document.createElement('p');
    errorMessage.id = this.errorMessageNodeId();
    errorMessage.classList.add('input-error-message', 'text-sm', 'text-red-700');
    errorMessage.textContent = message;

    this.containerTarget.appendChild(errorMessage);
  }

  clearErrorMessage() {
    const errorMessageNode = document.getElementById(this.errorMessageNodeId());

    if (errorMessageNode) this.containerTarget.removeChild(errorMessageNode);
  }

  errorMessageNodeId() {
    return `${this.containerTarget.id}-error-message`;
  }
}
