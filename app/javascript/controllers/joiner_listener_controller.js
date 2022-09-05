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
    console.log(this.joinmessageTarget)
    this.joinmessageTarget.innerText = "Vous allez rejoindre votre binôme de jeu"
    setTimeout(() => {  location.replace(`/game_matches/${data}/counter`) }, 3000)

  }



}
