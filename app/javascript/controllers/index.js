import { Application } from 'stimulus';
import { definitionsFromContext } from 'stimulus/webpack-helpers';

const application = Application.start();

const context = require.context('controllers', true, /\.js$/);

application.load(definitionsFromContext(context));


console.log("toto");





// Import and register all your controllers from the importmap under controllers/*

// import { application } from "controllers/application"   <+ put back

// import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading" <+ put back
// eagerLoadControllersFrom("controllers", application) <+ put back

// import HelloController from "./hello_controller"
// application.register("hello", HelloController)

// import HomeController from "./home_controller"
// application.register("home", HomeController)

// import NavbarController from "./navbar_controller"
// application.register("navbar", NavbarController)

// import CrewController from "./crew_controller"
// application.register("crew", CrewController)

// import DashboardController from "./dashboard_controller"
// application.register("dashboard", DashboardController)

// import FlatpickrController from "./flatpickr_controller"
// application.register("flatpickr", FlatpickrController)

// import ConcertController from "./concert_controller"
// application.register("concert", ConcertController)

// import ChecklistController from "./checklist_controller"
// application.register("checklist", ChecklistController)

// import ChecklistTemplateController from "./checklist_template_controller"
// application.register("checklist-template", ChecklistTemplateController)

// import ConcertmapController from "./concertmap_controller"
// application.register("concertmap", ConcertmapController)

// import AddressAutocompleteController from "./address_autocomplete_controller"
// application.register("address-autocomplete", AddressAutocompleteController)

// import UserConcertController from "./user_concert_controller"
// application.register("user-concert", UserConcertController)

// import MapUserConcertController from "./map_user_concert_controller"
// application.register("map-user-concert", MapUserConcertController)

// import ConcertTemplateController from "./concert_template_controller"
// application.register("concert-template", ConcertTemplateController)

// import TourController from "./tour_controller"
// application.register("tour", TourController)




// Eager load all controllers defined in the import map under controllers/**/*_controller
// import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
// eagerLoadControllersFrom("controllers", application)

// Lazy load controllers as they appear in the DOM (remember not to preload controllers in import map!)
// import { lazyLoadControllersFrom } from "@hotwired/stimulus-loading"
// lazyLoadControllersFrom("controllers", application)
