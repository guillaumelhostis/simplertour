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

  static targets = ["modal", "modaltwo*", "modalthree", "modalcontact", "modalguest", "modaltransport", "modaltransportuser*", "modaltransportattachments*", "modaltransportnotes*","venueattachments", "checklistTemplates", "modaltemplate", "templateName", "linkTemplate"];

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

  openModalGuest() {
    if (this.modalguestTarget) {
      this.modalguestTarget.style.display = "block";
      event.preventDefault();
    }
  }

  closeModalGuest(event) {
    if (this.modalguestTarget) {
      this.modalguestTarget.style.display = "none";
    }
  }

  openModalVenueAttachments(event) {
    if (this.venueattachmentsTarget) {
      event.preventDefault();
      this.venueattachmentsTarget.style.display = "block";
    }
  }

  closeModalVenueAttachments(event) {
    console.log("test")
    if (this.venueattachmentsTarget) {
      this.venueattachmentsTarget.style.display = "none";
    }
  }

  openModalChecklistTemplates(event) {
    if (this.checklistTemplatesTarget) {
      event.preventDefault();
      this.checklistTemplatesTarget.style.display = "block";
    }
  }

  closeModalChecklistTemplates(event) {
    console.log("test")
    if (this.checklistTemplatesTarget) {
      this.checklistTemplatesTarget.style.display = "none";
    }
  }

  openModalTransport(event) {
    if (this.modaltransportTarget) {
      event.preventDefault();
      this.modaltransportTarget.style.display = "block";
    }
  }

  closeModalTransport(event) {
    console.log("test")
    if (this.modaltransportTarget) {
      this.modaltransportTarget.style.display = "none";
    }
  }

  openModalTransportUser(event) {
    console.log("hey")
    const index = event.currentTarget.getAttribute("data-index");
    console.log(index)
    const modaltransportuserTarget = this.targets.find(`modaltransportuser${index}`);
    console.log(modaltransportuserTarget)
    modaltransportuserTarget.style.display = "block";
    event.preventDefault();

  }

  closeModalTransportUser(event) {
    const index = event.currentTarget.getAttribute("data-index");
    const modaltransportuserTarget = this.targets.find(`modaltransportuser${index}`);
    modaltransportuserTarget.style.display = "none";
  }

  openModalTransportAttachments(event) {
    const index = event.currentTarget.getAttribute("data-index");
    const modaltransportattachmentsTarget = this.targets.find(`modaltransportattachments${index}`);
    modaltransportattachmentsTarget.style.display = "block";
    event.preventDefault();

  }

  closeModalTransportAttachments(event) {
    const index = event.currentTarget.getAttribute("data-index");
    const modaltransportattachmentsTarget = this.targets.find(`modaltransportattachments${index}`);
    modaltransportattachmentsTarget.style.display = "none";
  }

  openModalTransportNotes(event) {
    const index = event.currentTarget.getAttribute("data-index");
    const modaltransportnotesTarget = this.targets.find(`modaltransportnotes${index}`);
    modaltransportnotesTarget.style.display = "block";
    event.preventDefault();

  }

  closeModalTransportNotes(event) {
    const index = event.currentTarget.getAttribute("data-index");
    const modaltransportnotesTarget = this.targets.find(`modaltransportnotes${index}`);
    modaltransportnotesTarget.style.display = "none";
  }

  openModalTemplate(event) {
    const modaltransportnotesTarget = this.targets.find(`modaltemplate`);
    modaltransportnotesTarget.style.display = "block";
    event.preventDefault();
  }

  closeModalTemplate(event) {
    const modaltransportnotesTarget = this.targets.find(`modaltemplate`);
    modaltransportnotesTarget.style.display = "none";
  }

  updateLink() {
    const link = this.linkTemplateTarget;
    const templateName = this.templateNameTarget.value;
    link.dataset.templateName = templateName;
    const linkPath = link.getAttribute("href");
    const updatedLinkPath = linkPath.split("?")[0] + "?template_name=" + templateName;
    link.setAttribute("href", updatedLinkPath);
  }
}
