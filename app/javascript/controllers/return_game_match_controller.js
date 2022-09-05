import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="game-matches"
export default class extends Controller {
    static values = {
      gameid: Number

    }

    connect() {
      console.log("hey")
      console.log(this.gameidValue)
      this.channel = createConsumer().subscriptions.create(
        { channel: "ReturnGameMatchChannel", id: this.gameidValue },
        {  received: data => this.#return(data)  }

       )
    }
    #return(data) {
      console.log("hey")
      setTimeout(() => {  location.replace(`/trip_sessions/new`) }, 3000)

    }
}
