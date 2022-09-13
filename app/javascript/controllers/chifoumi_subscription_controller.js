import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="chifoumi-subscription"
export default class extends Controller {
  static values = { gameId: Number, userId: Number }
  static targets = ["rock", "paper", "scissors", "choices", "nextRound", "textBtn", "yourChoice", "displayYourChoice",
   "roundResult", "competitorChoice", "displayCompetitorChoice", "infoSelectionPlayer", "endOfGameResult", "score",
   "infoStart", "roundCounter", "restart"]

  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "ChifoumiGameChannel", id: this.gameIdValue },
      { received: data => this.#nextAction(data) }
    )

    console.log(`Subscribe to the game_match with the id ${this.gameIdValue}.`);
    console.log(`user id is ${this.userIdValue}.`);
    console.log(`coucou le chat`);
  }

  #nextAction(data) {
    console.log(data.result === null);
    this.signs = ["rock", "paper", "scissors"]
    const currentUserIsPlayer = this.userIdValue === data.player
    const playRoundIsEven = data.play_round % 2 === 0
    // check if the received data is to restart the game or to update chifoumi choice of player
    if (data.next === "next-round") {
      this.#startRound(data);
    } else if (this.signs.includes(data.choice)){
      this.#selectChoice(data, currentUserIsPlayer, playRoundIsEven);
    } else if (data === this.gameIdValue) {
      this.#restartGame();
    }
  }

  #startRound(data) {
    if (this.hasInfoStartTarget) {
      this.infoStartTarget.classList.add("d-none")
    }
    if (data.play_round === 0) {
      this.roundCounterTarget.classList.remove("d-none")
      this.roundCounterTarget.innerHTML = `<h5>round 1</h5>`
    } else {
      this.roundCounterTarget.innerHTML = `<h5>round ${data.play_round / 2}</h5>`
    }
    this.choicesTarget.classList.remove("d-none");
    this.infoSelectionPlayerTarget.classList.remove("d-none");
    this.infoSelectionPlayerTarget.innerHTML = `<h6>Choisi ton signe</h6>`;
    this.nextRoundTarget.classList.add("d-none");
    this.roundResultTarget.classList.add("d-none");
    this.yourChoiceTarget.classList.add("d-none");
    this.competitorChoiceTarget.classList.add("d-none");
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
      this.choicesTarget.classList.add("d-none");
      this.yourChoiceTarget.classList.remove("d-none");
      this.displayYourChoiceTarget.classList = "";
      this.displayYourChoiceTarget.classList.add(`${data.choice}-gif`);
    }
    this.#displayInfo(data, currentUserIsPlayer, playRoundIsEven);
  }

  #evenPlayRoundAction(data, currentUserIsPlayer) {
    if (data.play_round === 2) {
      this.nextRoundTarget.classList.remove("d-none");
      this.scoreTarget.classList.remove("d-none");
      this.textBtnTarget.innerText = "prochaine manche"
    }
    this.textBtnTarget.innerText = "prochaine manche"
    this.infoSelectionPlayerTarget.classList.add("d-none");
    this.nextRoundTarget.classList.remove("d-none");
    this.roundResultTarget.innerHTML = `<h6>${data.winner}</h6>`;
    this.roundResultTarget.classList.remove("d-none");
    this.scoreTarget.innerHTML = `<h6>${data.score}</h6>`;
    if (currentUserIsPlayer){
      this.choicesTarget.classList.add("d-none");
      this.yourChoiceTarget.classList = "";
      this.displayYourChoiceTarget.classList = "";
      this.yourChoiceTarget.classList.remove("d-none");
      this.displayYourChoiceTarget.classList.add(`${data.choice}-gif`);
      this.competitorChoiceTarget.classList.remove("d-none");
      this.displayCompetitorChoiceTarget.classList = "";
      this.displayCompetitorChoiceTarget.classList.add(`${data.other_choice}-gif`);
    } else {
      this.competitorChoiceTarget.classList.remove("d-none");
      this.displayCompetitorChoiceTarget.classList = "";
      this.displayCompetitorChoiceTarget.classList.add(`${data.choice}-gif`);
    }
    if (data.result != null) {
      this.endOfGameResultTarget.classList.remove("d-none");
      this.endOfGameResultTarget.innerHTML = `<h6>${data.result}</h6><h4>à gagner la partie Bravo !</h4>`;
      this.nextRoundTarget.classList.add("d-none");
      this.restartTarget.classList.remove("d-none");
    }
  }

  #displayInfo(data, currentUserIsPlayer, playRoundIsEven) {
    if ( playRoundIsEven && data.play_round != 0 ) {
      this.infoSelectionPlayerTarget.classList.add("d-none");
    } else if (currentUserIsPlayer) {
      this.#updateInfo(data);
    }
  }

  #updateInfo() {
    if (this.infoSelectionPlayerTarget.innerHTML.trim() === `<h6>Choisi ton signe</h6>`) {
      this.infoSelectionPlayerTarget.innerHTML = `<h6>tu vas bientôt savoir le résultat</h6>`;
    } else {
      this.infoSelectionPlayerTarget.innerHTML = `<h6>Choisi ton signe</h6>`;
    }
  }

  #restartGame() {
    location.replace(`/game_matches/${this.gameIdValue + 1}`)
  }
}
