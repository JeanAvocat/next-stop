import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="tic-tac-toe-game-subscription"
export default class extends Controller {
  // static targets = ["tile1", "tile2", "tile3", "tile4", "tile5", "tile6", "tile7", "tile8", "tile9"]
  static values = { gameId: Number }
  static targets = ["tile"]

  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "TicTacToeGameChannel", id: this.gameIdValue },
      {  received: data => this.#updateTile(data) }
    )
    console.log(`Subscribe to the tic tac toe game with the id ${this.gameIdValue}.`)
    // console.log("hello tic tac toe");
    // console.log(this.tictactoeTarget)
  }


  #updateTile(data) {
    // event.preventDefault()
    // console.log(this.tictactoeTarget.innerHTML);
    console.log(data);
    // console.log(this.tileTargets)
    this.tileTargets.forEach(tile => {
      if (data.includes(tile.id)) {
        console.log(tile);
        tile.innerHTML = data
      }
    });
    // this.tictactoeTarget.innerHTML = data
    // this.tileTargets.forEach(target => {
    // console.log(target);
    // })
  }
}
