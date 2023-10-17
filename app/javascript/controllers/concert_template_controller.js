import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="concert-template"
export default class extends Controller {
  connect() {
    console.log("concert templat connected")
  }

  static targets = ["noteDescription*", "noteLinkTemplate*", "newNoteDescription", "newNoteTemplate", "entry*", "start*", "end*", "newentry", "newstart", "newend", "newentryTemplate", "newstartTemplate", "newendTemplate"];

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

  updateEntry(event) {
    const index = event.currentTarget.getAttribute("data-index");
    const link = this.targets.find(`entryTemplate${index}`);
    const noteDescription = this.targets.find(`entry${index}`).value;
    link.value = noteDescription;
    console.log(link)
  }

  updateStart(event) {
    const index = event.currentTarget.getAttribute("data-index");
    const link = this.targets.find(`startTemplate${index}`);
    const noteDescription = this.targets.find(`start${index}`).value;
    link.value = noteDescription;
    console.log(link)
  }

  updateEnd(event) {
    const index = event.currentTarget.getAttribute("data-index");
    const link = this.targets.find(`endTemplate${index}`);
    const noteDescription = this.targets.find(`end${index}`).value;
    link.value = noteDescription;
    console.log(link)
  }

  newEntry(event) {
    const link = this.targets.find(`newentryTemplate`);
    const noteDescription = this.targets.find(`newentry`).value;
    link.value = noteDescription;
  }

  newStart(event) {
    const link = this.targets.find(`newstartTemplate`);
    const noteDescription = this.targets.find(`newstart`).value;
    link.value = noteDescription;
  }

  newEnd(event) {
    const link = this.targets.find(`newendTemplate`);
    const noteDescription = this.targets.find(`newend`).value;
    link.value = noteDescription;
  }

}
