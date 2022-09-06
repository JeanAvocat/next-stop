import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="display-chat"
export default class extends Controller {
  static targets = ["displayChatGameMatch", "btnChatGameMatch"]
  connect() {
    console.log("coucou le chat on s'amuse");
    // console.log(this.displayChatGameMatchTarget.classList);
    console.log(this.btnChatGameMatchTarget);
  }

  hideChat() {
    this.displayChatGameMatchTarget.classList.toggle("hide-chat-game-match");
    this.btnChatGameMatchTarget.classList.toggle("chat-btn-opened");
    this.btnChatGameMatchTarget.classList.toggle("btn-fix-to-bottom");
  }
}
