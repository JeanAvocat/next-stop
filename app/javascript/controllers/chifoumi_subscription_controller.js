import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="chifoumi-subscription"
export default class extends Controller {
  static values = { gameId: Number, userId: Number }
  static targets = ["rock", "paper", "scissors", "choices", "nextRound", "yourChoice", "displayYourChoice",
   "roundResult", "competitorChoice", "displayCompetitorChoice", "infoSelectionPlayer"]

  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "ChifoumiGameChannel", id: this.gameIdValue },
      { received: data => this.#nextAction(data) }
    )

    console.log(`Subscribe to the game_match with the id ${this.gameIdValue}.`);
    console.log(`user id is ${this.userIdValue}.`);
    console.log(`coucou le chat`);
    // console.log(this.roundResultTarget.classList);
    // console.log(this.infoSelectionPlayerTarget.innerHTML.trim() === `<h6>Choisi ton signe</h6>`);
    // console.log(this.infoSelectionPlayerTarget.innerHTML.trim());
    // console.log(`<h6>Choisi ton signe</h6>`);
    // console.log(this.infoSelectionPlayerTarget.innerHTML = `<h6>tu vas bientôt savoir le résultat</h6>`);
  }

  #nextAction(data) {
    this.signs = ["rock", "paper", "scissors"]
    const currentUserIsPlayer = this.userIdValue === data.player
    const playRoundIsEven = data.play_round % 2 === 0
    // check if the received data is to restart the game or to update tic tac toe tile
    if (data.next === "next-round") {
      this.#startRound();
    } else if (this.signs.includes(data.choice)){
      this.#selectChoice(data, currentUserIsPlayer, playRoundIsEven);
    } else {
      this.#restartGame();
    }
  }


  #startRound() {
    this.choicesTarget.classList.remove("hidden");
    this.infoSelectionPlayerTarget.classList.remove("hidden");
    this.infoSelectionPlayerTarget.innerHTML = `<h6>Choisi ton signe</h6>`;
    this.nextRoundTarget.classList.add("hidden");
    this.roundResultTarget.classList.add("hidden");
    this.yourChoiceTarget.classList.add("hidden");
    this.competitorChoiceTarget.classList.add("hidden");
  }

  #selectChoice(data, currentUserIsPlayer, playRoundIsEven) {
    console.log(data);
    if (playRoundIsEven) {
      this.#evenPlayRoundAction(data, currentUserIsPlayer);
    } else {
      this.#oddPlayRoundAction(data, currentUserIsPlayer, playRoundIsEven);
    }
  }

  #oddPlayRoundAction(data, currentUserIsPlayer, playRoundIsEven) {
    if (currentUserIsPlayer){
      console.log(data);
      this.choicesTarget.classList.add("hidden");
      this.yourChoiceTarget.classList.remove("hidden");
      this.displayYourChoiceTarget.classList = "";
      this.displayYourChoiceTarget.classList.add(`${data.choice}-gif`);
    }
    this.#displayInfo(data, currentUserIsPlayer, playRoundIsEven);
  }

  #evenPlayRoundAction(data, currentUserIsPlayer) {
    this.infoSelectionPlayerTarget.classList.add("hidden");
    this.nextRoundTarget.classList.remove("hidden");
    this.roundResultTarget.innerHTML = `<h6>${data.winner}</h6>`;
    this.roundResultTarget.classList.remove("hidden")
    if (currentUserIsPlayer){
      this.choicesTarget.classList.add("hidden");
      this.yourChoiceTarget.classList.remove("hidden");
      this.displayYourChoiceTarget.classList = "";
      this.displayYourChoiceTarget.classList.add(`${data.choice}-gif`);
      this.competitorChoiceTarget.classList.remove("hidden");
      this.displayCompetitorChoiceTarget.classList = "";
      this.displayCompetitorChoiceTarget.classList.add(`${data.other_choice}-gif`);
    } else {
      this.competitorChoiceTarget.classList.remove("hidden");
      this.displayCompetitorChoiceTarget.classList = "";
      this.displayCompetitorChoiceTarget.classList.add(`${data.choice}-gif`);
    }
  }

  #displayInfo(data, currentUserIsPlayer, playRoundIsEven) {
    if ( playRoundIsEven && data.play_round != 0 ) {
      this.infoSelectionPlayerTarget.classList.add("hidden");
    } else if (currentUserIsPlayer) {
      this.#updateInfo(data);
    }
  }

  // #updateInfo() {
  //   if (infoSelectionPlayerTarget.innerHTML === `<h6>Choisi ton signe</h6>`) {
  //     infoSelectionPlayerTarget.innerHTML = `<h6>tu vas bientôt savoir le résultat</h6>`
  //   } else {
  //     infoSelectionPlayerTarget.innerHTML = `<h6>Choisi ton signe</h6>`
  //   }
  // }

  #updateInfo() {
    if (this.infoSelectionPlayerTarget.innerHTML.trim() === `<h6>Choisi ton signe</h6>`) {
      this.infoSelectionPlayerTarget.innerHTML = `<h6>tu vas bientôt savoir le résultat</h6>`;
    } else {
      this.infoSelectionPlayerTarget.innerHTML = `<h6>Choisi ton signe</h6>`;
    }
  }

  #restartGame() {

  }
}
