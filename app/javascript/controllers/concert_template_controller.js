import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="concert-template"
export default class extends Controller {
  connect() {
    console.log("concert templat connected")
  }

  static targets = ["noteDescription*", "noteLinkTemplate*", "newNoteDescription", "newNoteTemplate"];

  updateNote(event) {
    const index = event.currentTarget.getAttribute("data-index");
    const link = this.targets.find(`noteLinkTemplate${index}`);
    const linkindex = this.targets.find(`noteIndexTemplate${index}`);
    const noteDescription = this.targets.find(`noteDescription${index}`).value;
    link.value = noteDescription;
    linkindex.value = index
  }

  newNote(event) {
    const link = this.targets.find(`newNoteTemplate`);
    const noteDescription = this.targets.find(`newNoteDescription`).value;
    link.value = noteDescription;
  }
}
