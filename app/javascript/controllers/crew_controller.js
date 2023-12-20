import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="crew"
export default class extends Controller {
  connect() {

  }
  static targets = ["searchInput", "results", "selectUsers", "role*", "form*", "submit*", "crewuserrole*", "removerole*", "divplusorminus*"];

  search(event) {
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
    const divplusorminus = this.targets.find(`divplusorminus${index}`)
    divplusorminus.classList.add('d-none');
    divplusorminus.classList.remove('d-inline-block');
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
    const divplusorminus = this.targets.find(`divplusorminus${index}`)
    divplusorminus.classList.remove('d-none');
    divplusorminus.classList.add('d-inline-block');
    const putTarget = this.targets.find(`form${index}`);
    const formData = new FormData(putTarget);
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
        crewuserrole.innerHTML = `<p>${data.role}</p>`;
        divplusorminus.innerHTML =`<a data-action="click->crew#updateRole" data-url="/crews/1/update_role_in_crew_member/1" data-index="${index}" data-confirmmessage="Are you sure?" href="#"><i class="fa-solid fa-minus open-plus-icon"></i></a>` ;
      } else {
        // Handle errors here
        console.error('Error:', data.errors || data.message);
      }
    })
    .catch(error => {
      console.error('Error:', error);
    });
  }


  updateRole(event) {
    event.preventDefault()
    const index = event.currentTarget.getAttribute("data-index");
    const crewuserrole = this.targets.find(`crewuserrole${index}`)
    const divplusorminus = this.targets.find(`divplusorminus${index}`)
    const url = event.currentTarget.getAttribute("data-url") // Get the URL from the data attribute
    const token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
    // Prompt the user for confirmation

      // Send an AJAX request to update the role
      fetch(url, { method: "PUT", headers: {
        'X-CSRF-Token': token,
        'Content-Type': 'application/json',
      }, })
      .then(response => response.json())
      .then(data => {
        if (data.success) {
          // Handle success here
          console.log(data.message);

          // Update the role in the DOM
          crewuserrole.innerHTML = `<p></p>`;
          divplusorminus.innerHTML =`<a href="#" data-action="click->crew#openModal" data-index="${index}"><i class="fas fa-plus open-plus-icon"></i></a>` ;
        } else {
          // Handle errors here
          console.error('Error:', data.errors || data.message);
        }
      })
        .catch((error) => {
          console.error("Error:", error);
        });
  }
}
