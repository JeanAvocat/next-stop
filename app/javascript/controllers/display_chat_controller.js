import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="display-chat"
export default class extends Controller {
  static targets = ["displayChatGameMatch"]
  connect() {
    console.log("coucou le chat on s'amuse");
    // console.log(this.displayChatGameMatchTarget.classList);
  }

  hideChat() {
    this.displayChatGameMatchTarget.classList.toggle("hide-chat-game-match");
  }
}
