import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="game-matches"
export default class extends Controller {
  static targets = ["alertdeconnexion", "alertconnexion"]


  connect() {
    setTimeout(() => {  this.alertconnexionTarget.innerText= ""; }, 4000)
    setTimeout(() => {  this.alertdeconnexionTarget.innerText= ""; }, 4000)
  }

}
