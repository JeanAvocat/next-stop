import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="display-chat"
export default class extends Controller {
  static targets = ["displayChatGameMatch", "btnChatGameMatch", "messages", "emailIcon", "arrowIcon", "notifMessages"]
  connect() {
    console.log("coucou le chat on s'amuse");
  }

  hideChat() {
    console.log(this.notifMessagesTarget.classList);
    // display or hide chat
    this.displayChatGameMatchTarget.classList.toggle("hide-chat-game-match");
    // display chat btn according if chat is open or closed
    this.#toggleChatButton()
    // hide notification and remove text when we open the chat
    this.#updateNotificationWhenChatOpened()
    // scroll down the meassage div when we open the chat
    this.#scrollDown()
  }

  #toggleChatButton() {
     // return btn chat when opened
     this.btnChatGameMatchTarget.classList.toggle("chat-btn-opened");
     // add fix position to the btn when chat is closed
     this.btnChatGameMatchTarget.classList.toggle("btn-fix-to-bottom");
     // hide email Icon when chat is opened
     this.emailIconTarget.classList.toggle("chat-btn-closed-email-img");
     // hide arrow icon when chat is closed
     this.arrowIconTarget.classList.toggle("chat-btn-closed-arrow-img");
  }

  #updateNotificationWhenChatOpened() {
    // hide notification when we open the chat
    this.notifMessagesTarget.classList.remove("chat-notif-message");
    this.notifMessagesTarget.innerText = "";
  }

  #scrollDown() {
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
  }
}
