import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['checkbox'];

  connect() {

  }

  updateStatus(event) {
    event.preventDefault()
    const csrfToken = document.querySelector("meta[name='csrf-token']").content;
    console.log("CSRF Token:", csrfToken); // Check if this is logging the expected token

    // const index = event.currentTarget.getAttribute("data-index");
    const checklistId = event.currentTarget.getAttribute("data-id");
    const tourId = event.currentTarget.getAttribute("data-tour");
    const concertId =  event.currentTarget.getAttribute("data-concert");
    const newValue = this.checkboxTarget.checked;
    console.log("before patch")
    fetch(`/tours/${tourId}/concerts/${concertId}/checklists/${checklistId}`, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector("meta[name=csrf-token]").content,
      },
      body: JSON.stringify({ checklist: { status: newValue } }),
    })
      .then((response) => {
        if (response.ok) {
          // Optionally, you can update the UI to reflect the new status
        } else {
          // Handle error
        }
      })
      .catch((error) => {
        console.error("Error:", error);
      });
  }




}
