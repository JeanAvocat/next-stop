import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="tic-tac-toe-game-subscription"
export default class extends Controller {
  static values = { gameId: Number, result: Boolean }
  static targets = ["tile", "nickname", "competitor", "result"]

  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "TicTacToeGameChannel", id: this.gameIdValue },
      {  received: data => this.#updateTile(data) }
    )
    // console.log(`Subscribe to the tic tac toe game with the id ${this.gameIdValue}.`)
    // console.log("hello tic tac toe");
<<<<<<< HEAD
=======
    // console.log(this.tictactoeTarget)
>>>>>>> c4f5478ea5c7484a570c2d2b96a70ab0c1a97d4f
    // console.log(this.nicknameTarget.innerText)
  }

  disconnect() {
    this.channel.unsubscribe()
  }

  #updateTile(data) {
    // methode to update tile on both screen
    this.tileTargets.forEach(tile => {
      if (data.includes(tile.id)) {
        tile.outerHTML = data;
        this.#updatePlayer();
        this.#endOfGame(data);
      }
    });
  }

  #updatePlayer() {
    // methode to update info about player who have to play
    if (this.nicknameTarget.innerText === "C'est à ton tour de jouer") {
      this.nicknameTarget.innerText = `C'est au tour de ${this.competitorTarget.innerText}`;
    } else {
      this.nicknameTarget.innerText = "C'est à ton tour de jouer";
    }
  }

  #endOfGame(data) {
    // catch information if the game is finish and display it on the screen
    if ((data.includes("égalité")) || (data.includes("gagnant"))) {
      this.finalResult = data.split(`"`).filter(element => element.includes("gagnant") || element.includes("égalité")).join();
      this.resultTarget.innerHTML = `<h6> ${this.finalResult} </h6>`;
    }
  }
}
