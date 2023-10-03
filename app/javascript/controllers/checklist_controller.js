// app/javascript/controllers/checklist_controller.js
import { Controller } from 'stimulus';



export default class extends Controller {
  static targets = ['checkbox'];

  connect() {
    console.log('Checklist controller connected');
    console.log(this.checkboxTarget)
  }



  updateStatus(event) {
    event.preventDefault()
    // const index = event.currentTarget.getAttribute("data-index");
    const checklistId = event.currentTarget.getAttribute("data-id");
    const tourId = event.currentTarget.getAttribute("data-tour");
    console.log(tourId)
    const concertId =  event.currentTarget.getAttribute("data-concert");
    console.log(concertId)
    const newValue = this.checkboxTarget.checked;

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
