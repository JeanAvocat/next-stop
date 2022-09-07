import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="chatroom-subscription"
export default class extends Controller {
  static values = { chatroomId: Number, currentUserId: Number }
  static targets = ["messages", "buddy", "notifMessages", "ChatGameMatch"]

  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "ChatroomChannel", id: this.chatroomIdValue },
      { received: data => this.#insertMessageAndScrollDown(data)}
    )
  }

  resetForm(event) {
    event.target.reset()
  }

  disconnect() {
    this.channel.unsubscribe()
  }

  #insertMessageAndScrollDown(data) {
    const currentUserIsSender = this.currentUserIdValue === data.sender_id
    const messageElement = this.#buildMessageElement(currentUserIsSender, data.message)
    this.messagesTarget.insertAdjacentHTML("beforeend", messageElement)
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
    this.#addMessageNotification()
  }

  #buildMessageElement(currentUserIsSender, message) {
    return `
    <div class="message-row d-flex ${this.#justifyClass(currentUserIsSender)}">
      <div class="${this.#userStyleClass(currentUserIsSender)}">
        ${ currentUserIsSender ? message :  message.replace("Moi", this.buddyTarget.innerText) }
      </div>
    </div>
  `
  }

  #justifyClass(currentUserIsSender) {
    return currentUserIsSender ? "justify-content-end" : "justify-content-start"
  }

  #userStyleClass(currentUserIsSender) {
    return currentUserIsSender ? "sender-style" : "receiver-style"
  }

  #addMessageNotification() {
    if (this.ChatGameMatchTarget.classList.contains("hide-chat-game-match")) {
      this.notifMessagesTarget.classList.add("chat-notif-message");
      this.#computeNotifications()
    }
  }

  #computeNotifications() {
    if (this.notifMessagesTarget.innerText === "") {
      this.notifMessagesTarget.innerText = 1;
    } else {
      this.notifMessagesTarget.innerText = parseInt(this.notifMessagesTarget.innerText) + 1;
    }
  }
}
