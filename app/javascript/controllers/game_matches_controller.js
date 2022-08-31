import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="game-matches"
export default class extends Controller {
  static targets = ["counter"]
  connect() {
    console.log("heyy")
    const sessionid = this.element.dataset.sessionid
    setTimeout(() => {  this.counterTarget.innerText = 4; }, 1000)
    setTimeout(() => {  this.counterTarget.innerText = 3; }, 2000)
    setTimeout(() => {  this.counterTarget.innerText = 2; }, 3000)
    setTimeout(() => {  this.counterTarget.innerText = 1; }, 4000)
    setTimeout(() => {  this.counterTarget.innerText = 0; }, 5000)
    setTimeout(() => {  location.replace(`'/game_matches/${sessionid}/'`); }, 6000);
  }

}
