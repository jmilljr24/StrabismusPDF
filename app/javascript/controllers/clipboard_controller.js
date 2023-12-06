import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="clipboard"
export default class extends Controller {
  static targets = ["source"];
  connect() {
    console.log("Connecting to Clipboard");
  }
  copy() {
    console.log(this.sourceTarget.textContent.trim());
    navigator.clipboard.writeText(this.sourceTarget.textContent.trim());
  }
}
