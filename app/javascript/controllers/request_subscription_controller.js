import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="request-subscription"
export default class extends Controller {
  static values = { requestId: Number }
  static targets = ["request", "sendRequest", "answerRequest", "user"]

  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "RequestChannel", id: this.requestIdValue },
      { received: data => this.nextAction(data) }
    )
    // this.answerRequestTarget.style.display = "none";
    console.log(`the request is on the game_match ${this.requestIdValue}.`);
  }

  nextAction(data){
    const user = this.element.dataset.user;
    console.log(data);
    const sender_user = data;
    if (user == sender_user) {
      // console.log("I sent the request");
      // this.sendRequestTarget.style.display = "none";
      this.sendRequestTarget.classList.add("d-none");
    } else {
      // console.log("I must choose");
      // this.sendRequestTarget.style.display = "none";
      // this.answerRequestTarget.style.display = "block";
      this.sendRequestTarget.classList.add("d-none");
      this.answerRequestTarget.classList.remove("d-none")
    }
  }

  disableAnswerRequest() {
    console.log("la réponse est envoyée");
    this.answerRequestTarget.style.display = "none";
  }
}
