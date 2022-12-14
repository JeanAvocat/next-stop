import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal-quit"
export default class extends Controller {

  static targets = ["modal", "modalQuitContainer"]
  connect() {
    // console.log("connected")
  }

  displayModal(event) {
    // console.log(this.fullContentTarget)
    event.preventDefault()
    this.modalTarget.classList.toggle("d-none")
    this.modalQuitContainerTarget.classList.toggle("d-none")
  }
}
