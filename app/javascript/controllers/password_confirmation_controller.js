import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["password", "passwordConfirmation"];

  changed() {
    this.passwordConfirmationTarget.setCustomValidity(
      this.hasMatchingPasswords() ? "" : "Passwords must match."
    );
  }

  hasMatchingPasswords() {
    return this.passwordTarget.value == this.passwordConfirmationTarget.value;
  }
}
