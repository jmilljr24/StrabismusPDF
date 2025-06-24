import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="upload"
export default class extends Controller {
  static targets = ["input", "submit", "filename"];

  connect() {
    console.log("upload connected")
    this.toggleSubmit(false);
  }

  updateFile() {
    const file = this.inputTarget.files[0];
    if (file) {
      this.filenameTarget.textContent = file.name;
      this.toggleSubmit(true);
    } else {
      this.filenameTarget.textContent = "";
      this.toggleSubmit(false);
    }
  }

  toggleSubmit(enabled) {
    this.submitTarget.disabled = !enabled;
  }
}
