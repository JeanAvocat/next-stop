import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="chifoumi-subscription"
export default class extends Controller {
  static values = { gameId: Number }
  static targets = ["rock", "paper", "scissors"]

  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "ChifoumiGameChannel", id: this.gameIdValue },
      { received: data => console.log(data) }
    )

    console.log(`Subscribe to the game_match with the id ${this.gameIdValue}.`);
    console.log(`coucou le chat`);
  }
}
