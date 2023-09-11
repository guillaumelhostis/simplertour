import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

// Connects to data-controller="concert"
export default class extends Controller {
  connect() {

    console.log("concert controller connected")
    flatpickr(".hour-pickr", {
      noCalendar: true,
      enableTime: true,
      dateFormat: 'h:i K'

    })
  }

  static targets = ["modal"];

  openModal() {
    if (this.modalTarget) {
      this.modalTarget.style.display = "block";
      event.preventDefault();
    }
  }

  closeModal(event) {



    if (this.modalTarget) {
      this.modalTarget.style.display = "none";
    }
  }
}
