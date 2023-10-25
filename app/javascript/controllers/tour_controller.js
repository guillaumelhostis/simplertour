import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tour"
export default class extends Controller {
  connect() {

  }

  static targets = ["modaltemplatelist"]

  openTemplateListModal(event) {
    const roleTarget = this.targets.find(`modaltemplatelist`);
    roleTarget.classList.remove('d-none');
    roleTarget.classList.add('d-block');
    event.preventDefault();
  }

  closeTemplateListModal() {
    const roleTarget = this.targets.find(`modaltemplatelist`);
    roleTarget.classList.add('d-none');
    roleTarget.classList.remove('d-block');
  }
}
