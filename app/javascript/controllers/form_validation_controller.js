import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [
        "name", "email", "password", "passwordConfirmation",
        "nameError", "emailError", "passwordError", "passwordConfirmationError",
        "submitButton"
      ]

  connect() {
    console.log ("connected to the form_edit");
    this.submitButtonTarget.addEventListener("click", (event) => {
      if (!this.validateForm()) {
        event.preventDefault()
      }
    })
  }

  clearErrors() {
    this.nameErrorTarget.textContent = ""
    this.emailErrorTarget.textContent = ""
    this.passwordErrorTarget.textContent = ""
    this.passwordConfirmationErrorTarget.textContent = ""
  }

  validateForm() {
    return this.validateName() &&
           this.validateEmail() &&
           this.validatePassword() &&
           this.validatePasswordConfirmation()
  }

  validateName() {
    const name = this.nameTarget.value
    if (name.length < 5 || name.length > 50) {
      this.nameErrorTarget.textContent = "Name must be between 1 and 50 characters."
      this.nameTarget.focus()
      return false
    }
    return true
  }

  validateEmail() {
    const email = this.emailTarget.value
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
    if (!emailRegex.test(email)) {
      this.emailErrorTarget.textContent = "Please enter a valid email address."
      this.emailTarget.focus()
      return false
    }
    return true
  }

  validatePassword() {
    const password = this.passwordTarget.value
    if (password.length < 5 || password.length > 50) {
      this.passwordErrorTarget.textContent = "Password must be between 5 and 50 characters."
      this.passwordTarget.focus()
      return false
    }
    return true
  }

  validatePasswordConfirmation() {
    const password = this.passwordTarget.value
    const passwordConfirmation = this.passwordConfirmationTarget.value
    if (password !== passwordConfirmation) {
      this.passwordConfirmationErrorTarget.textContent = "Passwords do not match."
      this.passwordConfirmationTarget.focus()
      return false
    }
    return true
  }
}
