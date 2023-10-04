import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";

export default class extends Controller {
  static targets = ["calendar"];
  calendarInstance = null;


  connect() {
    console.log("controller flatpickr")
    this.initFlatpickr();


  }

  initFlatpickr() {
    const sixMonthsAgo = new Date();
    sixMonthsAgo.setMonth(sixMonthsAgo.getMonth() - 6);

    this.calendarInstance = flatpickr("#calendar", {
      mode: "multiple",
      dateFormat: "Y-m-d",
      minDate: sixMonthsAgo,
      inline: true,
      static: true,
      showMonths: 12,
      numberOfMonths: [6, 6],
      showYearDropdown: true,
      yearDropdown: true,
      onReady: this.handleCalendarReady.bind(this),
      onChange: this.handleDateChange.bind(this),
      onMonthChange: this.handleMonthChange.bind(this),

    });
  }

  handleCalendarReady(selectedDates, dateStr, instance) {
    // Initial rendering of custom classes
    this.applyCustomClasses(instance);
  }

  handleMonthChange(selectedDates, dateStr, instance) {
    // Reapply custom classes when the month changes
    this.applyCustomClasses(instance);
  }



  handleDateChange(selectedDates, dateStr, instance) {
    const concertDateToIdMap = {};
    const concertDates = JSON.parse(this.calendarTarget.getAttribute("data-concert-dates"));
    const concertIndex = JSON.parse(this.calendarTarget.getAttribute("data-concert-index"));
    for (let i = 0; i < concertDates.length; i++) {
      concertDateToIdMap[concertDates[i]] = concertIndex[i];
    }


    const parsedConcertDates = JSON.parse(this.calendarTarget.getAttribute("data-concert-dates"));
    const tourIndex = this.calendarTarget.getAttribute("data-tour-index");
    const dayElements = instance.calendarContainer.querySelectorAll(".flatpickr-day");


    // Function to debounce class application
    const applyClassDebounced = () => {
      dayElements.forEach((day) => {
        const ariaLabel = day.getAttribute("aria-label");
        if (parsedConcertDates.includes(ariaLabel.replace(/\s/g,''))) {
          const matchingConcertId = concertDateToIdMap[ariaLabel.replace(/\s/g, '')];
          day.classList.add("background-color-red");

        } else {
          day.classList.remove("background-color-red");
        }
      });
    };

    // Delay applying the class to avoid flickering during redraws
    setTimeout(() => {
      this.applyCustomClasses(instance);
      this.attachLinkClickHandlers(instance);
    }, 100);
  }

  applyCustomClasses(instance) {
  const concertDateToIdMap = {};
  const concertDates = JSON.parse(this.calendarTarget.getAttribute("data-concert-dates"));
  const concertIndex = JSON.parse(this.calendarTarget.getAttribute("data-concert-index"));
  const concertStatus = JSON.parse(this.calendarTarget.getAttribute("data-concert-status"));
  for (let i = 0; i < concertDates.length; i++) {
    concertDateToIdMap[concertDates[i]] = {
      id: concertIndex[i],
      status: concertStatus[i] // Add the status information to the map
    };
  }


  const parsedConcertDates = JSON.parse(this.calendarTarget.getAttribute("data-concert-dates"));
  const tourIndex = this.calendarTarget.getAttribute("data-tour-index");
  const dayElements = instance.calendarContainer.querySelectorAll(".flatpickr-day");




  dayElements.forEach((day) => {
    const ariaLabel = day.getAttribute("aria-label");

    if (parsedConcertDates.includes(ariaLabel.replace(/\s/g, ''))) {
      const matchingConcertId = concertDateToIdMap[ariaLabel.replace(/\s/g, '')];
      const dayNumber = parseInt(ariaLabel.split(' ')[1], 10); // Extract and parse the day number
      if (matchingConcertId.status === 0) {
        day.classList.add("background-color-red");
      } else if (matchingConcertId.status === 1) {
        day.classList.add("background-color-orange");
      } else if (matchingConcertId.status === 2) {
        day.classList.add("background-color-green");
      } else if (matchingConcertId.status === 3) {
        day.classList.add("background-color-grey");
      }
      day.innerHTML = `<a href="/tours/${matchingConcertId.id}/concerts/${tourIndex}">${dayNumber}</a>`;
    }
  });
  }

  attachLinkClickHandlers(instance) {
    const linkElements = instance.calendarContainer.querySelectorAll(".flatpickr-day a");

    linkElements.forEach((link) => {
      link.addEventListener("click", (event) => {
        event.preventDefault(); // Prevent the default link behavior

        const href = link.getAttribute("href"); // Get the href attribute

        // Navigate to the new page using JavaScript
        window.location.href = href;
      });
    });
  }
}
