import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal-quit"
export default class extends Controller {

  static targets = ["modal", "arrow"]
  connect() {
    console.log("connected")
  }

  displayModal(event) {
    console.log("Coucou")
    event.preventDefault()
    this.modalTarget.classList.toggle("d-none")
    // this.arrowTarget.classList.toggle("d-none")
  }
}
