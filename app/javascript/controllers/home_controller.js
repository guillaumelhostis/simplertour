import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="home"
export default class extends Controller {
  connect() {
    console.log("Home controller")
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
