import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="game-matches"
export default class extends Controller {
    static targets = [ "leavemessage"]
    static values = {
      gameid: Number

    }

    connect() {
      // console.log("hey")
      // console.log(this.gameidValue)

      this.channel = createConsumer().subscriptions.create(
        { channel: "ReturnGameMatchChannel", id: this.gameidValue },
        {  received: data => this.#return(data)  }

       )
    }
    #return() {
      setTimeout(() => {  location.replace(`/trip_sessions/new`) }, 7000)
      this.leavemessageTarget.innerText = "Oups, ton adversaire est arrivé à bon port et a quitté la partie"
      setTimeout(() => {  this.leavemessageTarget.innerText = "Tu vas être redirigé pour jouer avec un nouveau voisin de rame"}, 4000)

    }
}
