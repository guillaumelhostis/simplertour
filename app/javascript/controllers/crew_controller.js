import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="crew"
export default class extends Controller {
  connect() {
    console.log('CrewController')
  }
  static targets = ["searchInput", "results", "selectUsers", "role*", "form*", "submit*", "crewuserrole*"];

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

  openModal(event) {
    const index = event.currentTarget.getAttribute("data-index");
    console.log("Index:", index);// Get the index from the data attribute
    const roleTarget = this.targets.find(`role${index}`);
    console.log("Role Target:", roleTarget);



      roleTarget.classList.add('d-inline-block');
      roleTarget.classList.remove('d-none');

    event.preventDefault();
  }

  closeModal(event) {
    event.preventDefault();

    const index = event.currentTarget.getAttribute("data-index");
    const roleTarget = this.targets.find(`role${index}`);
    const crewuserrole = this.targets.find(`crewuserrole${index}`)
    roleTarget.classList.add('d-none');
    roleTarget.classList.remove('d-inline-block');

    const putTarget = this.targets.find(`form${index}`);
    const formData = new FormData(putTarget);

    console.log(putTarget);
    for (var [key, value] of formData.entries()) {
      console.log(key, value);
    }


    fetch(putTarget.action, {
      method: 'PUT',
      body: formData,
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
      },
    })
    .then(response => response.json())
    .then(data => {
      if (data.success) {
        // Handle success here
        console.log(data.message);

        // Update the role in the DOM
        crewuserrole.innerHTML = data.role;
      } else {
        // Handle errors here
        console.error('Error:', data.errors || data.message);
      }
    })
    .catch(error => {
      console.error('Error:', error);
    });
  }
}
