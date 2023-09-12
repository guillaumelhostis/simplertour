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

  static targets = ["modal", "modaltwo*", "modalthree", "modalcontact"];

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

  openModalTwo(event) {
    const index = event.currentTarget.getAttribute("data-index");
    console.log(index)
    const roleTarget = this.targets.find(`modaltwo${index}`);
    console.log(roleTarget)

    roleTarget.classList.remove('d-none');
    roleTarget.classList.add('d-block');
    event.preventDefault();

  }

  closeModalTwo(event) {
    const index = event.currentTarget.getAttribute("data-index");

    const roleTarget = this.targets.find(`modaltwo${index}`);




    roleTarget.classList.add('d-none');
    roleTarget.classList.remove('d-block');

  }


  openModalThree() {
    if (this.modalthreeTarget) {
      this.modalthreeTarget.style.display = "block";
      event.preventDefault();
    }
  }

  closeModalThree(event) {
    if (this.modalthreeTarget) {
      this.modalthreeTarget.style.display = "none";
    }
  }

  openModalContact() {
    if (this.modalcontactTarget) {
      this.modalcontactTarget.style.display = "block";
      event.preventDefault();
    }
  }

  closeModalContact(event) {
    if (this.modalcontactTarget) {
      this.modalcontactTarget.style.display = "none";
    }
  }

}
