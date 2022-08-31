import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["counter"]

  connect() {
    console.log("eee")
  }
}
