import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="crew"
export default class extends Controller {
  connect() {
    console.log('CrewController')
  }
  static targets = ["searchInput", "results", "selectUsers", "role"];

  search(event) {
    console.log('Search method called');
    const searchTerm = event.target.value.trim().toLowerCase();
    const selectUsers = this.selectUsersTarget;

    if (searchTerm.length === 0) {
      // Clear the select list when there's no search term
      selectUsers.innerHTML = "";
      selectUsers.classList.add("d-none"); // Add the 'd-none' class
      return;
    }

    // Perform AJAX request to search for users
    // Replace '/pages/search' with the actual endpoint to search users
    fetch(`/pages/search?query=${searchTerm}`)
      .then((response) => response.json())
      .then((data) => {
        this.resultsTarget.innerHTML = "";

        // Create an empty array to store the options
        const options = [];

        data.forEach((user) => {
          // Add each user as an option
          options.push(`<option value="${user.id}">${user.first_name} ${user.last_name}</option>`);
        });

        // Update the select tag's options with the search results
        selectUsers.innerHTML = options.join("");

        // Remove the 'd-none' class to show the select tag
        selectUsers.classList.remove("d-none");
      })
      .catch((error) => {
        console.error("Error:", error);
      });


  }

  openModal() {
    this.roleTarget.classList.add('d-inline-block');
    this.roleTarget.classList.remove('d-none');
    event.preventDefault();

  }

  closeModal() {
    this.roleTarget.style.display = "none";
  }
}
