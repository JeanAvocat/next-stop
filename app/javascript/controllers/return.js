import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="game-matches"
export default class extends Controller {
    static targets = [ "leaveplayer"]
    static values = {
      status: String,
      url: String,
      sessionid: Number

    }

    connect() {
      console.log("hey")
    }
    return() {
      console.log(this.leaveplayerTarget)
      // this.joinmessageTarget.innerText = "Vous allez rejoindre votre binôme de jeu"
      // setTimeout(() => {  location.replace(`/game_matches/${data}/counter`) }, 3000)

    }
}
