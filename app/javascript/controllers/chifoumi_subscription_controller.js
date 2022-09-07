import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="chifoumi-subscription"
export default class extends Controller {
  static values = { gameId: Number }
  static targets = ["rock", "paper", "scissors"]

  connect() {
    console.log(`Subscribe to the game_match with the id ${this.gameIdValue}.`)
    console.log(`coucou le chat`)
  }
}
