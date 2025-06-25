import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="upload"
export default class extends Controller {
  static targets = ["input", "submit", "filename", "uploadArea", "loading"];

  connect() {
    console.log("upload connected")
    this.toggleSubmit(false);
    this.hideLoading();
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
  submit(event) {
    if (this.submitTarget.disabled) return

    this.submitTarget.disabled = true
    this.uploadAreaTarget.classList.add("hidden")
    this.loadingTarget.classList.remove("hidden")
  }
  toggleSubmit(enabled) {
    this.submitTarget.disabled = !enabled;
  }
  hideLoading() {
    if (this.hasLoadingTarget) {
      this.loadingTarget.classList.add("hidden")
    }
  }
}
