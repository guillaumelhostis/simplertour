import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {
  connect() {
    console.log("Navbar Controller")
  }
  static targets = ["modal"];

  openModal() {
    if (this.modalTarget) {
      this.modalTarget.style.display = "block";
      event.preventDefault();
    }
  }

  closeModal() {
    if (this.modalTarget) {
      this.modalTarget.style.display = "none";
    }
  }

}
