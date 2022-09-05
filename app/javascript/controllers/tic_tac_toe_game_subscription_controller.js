import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="tic-tac-toe-game-subscription"
export default class extends Controller {
  static values = { gameId: Number, result: Boolean }
  static targets = ["tile", "gameInfo", "competitor", "restart"]

  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "TicTacToeGameChannel", id: this.gameIdValue },
      {  received: data => this.#nextAction(data) }
    )
    // console.log(`Subscribe to the tic tac toe game with the id ${this.gameIdValue}.`)
    // console.log("hello tic tac toe");
    // console.log(this.gameInfoTarget.innerText)
    // console.log(this.restartTarget.outerHTML);
  }

  disconnect() {
    this.channel.unsubscribe()
  }

  #nextAction(data) {
    // check if the received data is to restart the game or to update tic tac toe tile
    if (data === this.gameIdValue) {
      this.#restartGame();
    } else {
      this.#updateTile(data);
    }
  }

  #restartGame() {
    location.replace(`/game_matches/${this.gameIdValue + 1}`)
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
    if (this.gameInfoTarget.innerText === "C'est à ton tour de jouer") {
      this.gameInfoTarget.innerText = `C'est au tour de ${this.competitorTarget.innerText}`;
    } else {
      this.gameInfoTarget.innerText = "C'est à ton tour de jouer";
    }
  }

  #endOfGame(data) {
    // catch information if the game is finish and display it on the screen
    if ((data.includes("égalité")) || (data.includes("gagnant"))) {
      this.finalResult = data.split(`"`).filter(element => element.includes("gagnant") || element.includes("égalité")).join();
      this.gameInfoTarget.innerText = this.finalResult;
      this.restartTarget.classList.remove("hidden");
    }
  }
}
