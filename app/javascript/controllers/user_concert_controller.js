import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="user-concert"
export default class extends Controller {
  connect() {
  }

  static targets = ["modalusertransportattachments*"];

  openModalTransportAttachments(event) {
    const index = event.currentTarget.getAttribute("data-index");
    const modaltransportattachmentsTarget = this.targets.find(`modalusertransportattachments${index}`);
    modaltransportattachmentsTarget.style.display = "block";
    event.preventDefault();

  }

  closeModalTransportAttachments(event) {
    const index = event.currentTarget.getAttribute("data-index");
    const modaltransportattachmentsTarget = this.targets.find(`modalusertransportattachments${index}`);
    modaltransportattachmentsTarget.style.display = "none";
  }
}
