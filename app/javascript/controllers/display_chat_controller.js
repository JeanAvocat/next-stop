import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="display-chat"
export default class extends Controller {
  static targets = ["displayChatGameMatch", "btnChatGameMatch", "messages", "emailIcon", "arrowIcon"]
  connect() {
    console.log("coucou le chat on s'amuse");
    // console.log(this.displayChatGameMatchTarget.classList);
    console.log(this.btnChatGameMatchTarget);
  }

  hideChat() {
    this.displayChatGameMatchTarget.classList.toggle("hide-chat-game-match");
    this.btnChatGameMatchTarget.classList.toggle("chat-btn-opened");
    this.btnChatGameMatchTarget.classList.toggle("btn-fix-to-bottom");
    this.emailIconTarget.classList.toggle("chat-btn-closed-email-img");
    this.arrowIconTarget.classList.toggle("chat-btn-closed-arrow-img");
    this.#scrollDown()
  }

  #scrollDown() {
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
  }
}
