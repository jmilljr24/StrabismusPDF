import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="content-loader"
export default class extends Controller {
  static targets = ["link"];
  connect() {
    console.log("Connected to content-loader controller");
  }
}
