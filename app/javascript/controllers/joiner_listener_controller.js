import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="game-matches"
export default class extends Controller {
  static targets = [ "joinmessage"]
  static values = {
    status: String,
    url: String,
    sessionid: Number

  }
  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "ListenJoinerChannel", id: this.sessionidValue },
      {  received: data => this.#changeMessage(data)  }

     )
  }
  #changeMessage(data) {
    this.joinmessageTarget.innerText = "Ton adversaire est sur le point de rejoindre la partie"
    setTimeout(() => {  location.replace(`/game_matches/${data}/counter`) }, 3000)
  }
}
