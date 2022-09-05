import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="game-matches"
export default class extends Controller {
  static values = {
    status: String,
    url: String,
    sessionid: Number

  }

  connect() {
  console.log(`hey ${this.sessionidValue}`);
  console.log(`hey ${this.statusValue}`);
    // // if (this.statusValue === "in game") {
    // //   location.replace(this.urlValue)
    // }
    this.channel = createConsumer().subscriptions.create(
      { channel: "ListenJoinerChannel", id: this.sessionidValue },
      {  received: data => console.log(data)  }
     )
  }
  


}
