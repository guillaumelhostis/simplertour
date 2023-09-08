import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

// Connects to data-controller="flatpickr"
export default class extends Controller {
  connect() {
    console.log("flatpickr controller on")

    flatpickr(".date_pickr", {




    })

  }



}
