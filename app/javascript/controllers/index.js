// Import and register all your controllers from the importmap under controllers/*

import { application } from "controllers/application"

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import HomeController from "./home_controller"
application.register("home", HomeController)

import NavbarController from "./navbar_controller"
application.register("navbar", NavbarController)

import CrewController from "./crew_controller"
application.register("crew", CrewController)

import DashboardController from "./dashboard_controller"
application.register("dashboard", DashboardController)



// Eager load all controllers defined in the import map under controllers/**/*_controller
// import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
// eagerLoadControllersFrom("controllers", application)

// Lazy load controllers as they appear in the DOM (remember not to preload controllers in import map!)
// import { lazyLoadControllersFrom } from "@hotwired/stimulus-loading"
// lazyLoadControllersFrom("controllers", application)
