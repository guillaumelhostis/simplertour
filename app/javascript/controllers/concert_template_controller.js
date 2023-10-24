import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="concert-template"
export default class extends Controller {
  connect() {
    console.log("concert templat connected")
  }

  static targets = ["noteDescription*", "noteLinkTemplate*", "newNoteDescription", "newNoteTemplate", "entry*", "start*", "end*", "newentry", "newstart", "newend", "newentryTemplate", "newstartTemplate", "newendTemplate",  "checkboxDescription*", "checkboxLinkTemplate*", "newCheckboxTemplate", "newCheckboxDescription", "placeDepart*", "timeDepart*", "timeArrival*", "placeArrival*", "placeDepartTemplate*", "timeDepartTemplate*", "placeArrivalTemplate*", "timeArrivalTemplate*", "newArrivalTime", "newArrivalPlace", "newDepartTime", "newDepartPlace", "newDepartPlaceTemplate", "newDepartTimeTemplate", "newArrivalPlaceTemplate", "newArrivalTimeTemplate", "name", "nameTemplate", "newWayTemplate", "newWay", "updateHotelName*", "updateHotelAddress*", "updateHotelPostCode*", "updateHotelCity*", "updateHotelNameTemplate*", "updateHotelAddressTemplate*", "updateHotelPostCodeTemplate*", "updateHotelCityTemplate*","newHotelNameTemplate", "newHotelName", "newHotelCityTemplate", "newHotelCity", "newHotelPostCodeTemplate", "newHotelPostCode", "newHotelAddressTemplate", "newHotelAddress" ];

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

  updateCheckbox(event) {
    const index = event.currentTarget.getAttribute("data-index");
    const link = this.targets.find(`checkboxLinkTemplate${index}`);
    const noteDescription = this.targets.find(`checkboxDescription${index}`).value;
    link.value = noteDescription;
    console.log(noteDescription)
  }

  newCheckbox(event) {
    const link = this.targets.find(`newCheckboxTemplate`);
    const noteDescription = this.targets.find(`newCheckboxDescription`).value;
    link.value = noteDescription;
  }

  updateArrivalPlace(event) {
    const index = event.currentTarget.getAttribute("data-index");
    const link = this.targets.find(`placeArrivalTemplate${index}`);
    const noteDescription = this.targets.find(`placeArrival${index}`).value;
    link.value = noteDescription;
    console.log(link)
  }

  updateArrivalTime(event) {
    const index = event.currentTarget.getAttribute("data-index");
    const link = this.targets.find(`timeArrivalTemplate${index}`);
    const noteDescription = this.targets.find(`timeArrival${index}`).value;
    link.value = noteDescription;
    console.log(link)
  }

  updateDepartPlace(event) {
    const index = event.currentTarget.getAttribute("data-index");
    const link = this.targets.find(`placeDepartTemplate${index}`);
    const noteDescription = this.targets.find(`placeDepart${index}`).value;
    link.value = noteDescription;
    console.log(link)
  }

  updateDepartTime(event) {
    const index = event.currentTarget.getAttribute("data-index");
    const link = this.targets.find(`timeDepartTemplate${index}`);
    const noteDescription = this.targets.find(`timeDepart${index}`).value;
    link.value = noteDescription;
    console.log(link)
  }

  newDepartPlace(event) {
    const link = this.targets.find(`newDepartPlaceTemplate`);
    const noteDescription = this.targets.find(`newDepartPlace`).value;
    link.value = noteDescription;
    console.log(link)
  }

  newDepartTime(event) {
    const link = this.targets.find(`newDepartTimeTemplate`);
    const noteDescription = this.targets.find(`newDepartTime`).value;
    link.value = noteDescription;
  }

  newArrivalPlace(event) {
    const link = this.targets.find(`newArrivalPlaceTemplate`);
    const noteDescription = this.targets.find(`newArrivalPlace`).value;
    link.value = noteDescription;
  }

  newArrivalTime(event) {
    const link = this.targets.find(`newArrivalTimeTemplate`);
    const noteDescription = this.targets.find(`newArrivalTime`).value;
    link.value = noteDescription;
  }

  updateName(event) {
    const link = this.targets.find(`nameTemplate`);
    const noteDescription = this.targets.find(`name`).value;
    link.value = noteDescription;
  }

  updateHotelName(event) {
    const index = event.currentTarget.getAttribute("data-index");
    const link = this.targets.find(`updateHotelNameTemplate${index}`);
    const noteDescription = this.targets.find(`updateHotelName${index}`).value;
    link.value = noteDescription;

  }

  updateHotelAddress(event) {
    const index = event.currentTarget.getAttribute("data-index");
    const link = this.targets.find(`updateHotelAddressTemplate${index}`);
    const noteDescription = this.targets.find(`updateHotelAddress${index}`).value;
    link.value = noteDescription;

  }

  updateHotelPostCode(event) {
    const index = event.currentTarget.getAttribute("data-index");
    const link = this.targets.find(`updateHotelPostCodeTemplate${index}`);
    const noteDescription = this.targets.find(`updateHotelPostCode${index}`).value;
    link.value = noteDescription;

  }

  updateHotelCity(event) {
    const index = event.currentTarget.getAttribute("data-index");
    const link = this.targets.find(`updateHotelCityTemplate${index}`);
    const noteDescription = this.targets.find(`updateHotelCity${index}`).value;
    link.value = noteDescription;

  }

  newHotelName(event) {
    const link = this.targets.find(`newHotelNameTemplate`);
    const noteDescription = this.targets.find(`newHotelName`).value;
    link.value = noteDescription;
  }

  newHotelAddress(event) {
    const link = this.targets.find(`newHotelAddressTemplate`);
    const noteDescription = this.targets.find(`newHotelAddress`).value;
    link.value = noteDescription;
  }

  newHotelPostCode(event) {
    const link = this.targets.find(`newHotelPostCodeTemplate`);
    const noteDescription = this.targets.find(`newHotelPostCode`).value;
    link.value = noteDescription;
  }

  newHotelCity(event) {
    const link = this.targets.find(`newHotelCityTemplate`);
    const noteDescription = this.targets.find(`newHotelCity`).value;
    link.value = noteDescription;
  }
}
