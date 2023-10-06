import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="checklist-template"
export default class extends Controller {
  connect() {
  }

  static targets = ["descriptions"];

  addDescription(event) {

    event.preventDefault()

    const newDescription = this.descriptionsTarget.firstElementChild.cloneNode(true)
    const index = new Date().getTime() // Use a timestamp as a unique identifier
    newDescription.innerHTML = newDescription.innerHTML.replace(/_INDEX_/g, index)
    this.descriptionsTarget.appendChild(newDescription)
    this.descriptionsTarget.querySelectorAll(".remove-nested-field").forEach(link => {
      link.addEventListener("click", this.removeDescription.bind(this))
    })
  }

  removeDescription(event) {
    event.preventDefault()
    const removeLink = event.target
    const nestedField = removeLink.closest(".nested-fields")
    if (nestedField) {
      // Find the hidden "_destroy" input field within the nested field
      const destroyInput = nestedField.querySelector("input[name*='_destroy']")
      // If the "_destroy" input exists, set its value to "1" to mark for deletion
      if (destroyInput) {
        destroyInput.value = "1"
      }
      // Remove the nested field from the DOM
      nestedField.remove()
    }
  }
}
