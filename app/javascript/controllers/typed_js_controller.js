import { Controller } from "@hotwired/stimulus"
import Typed from "typed.js"

// Connects to data-controller="typed-js"
export default class extends Controller {
  connect() {
    console.log("hello world");
    new Typed(this.element, {
      strings: ['Chaque bonne journée commence par un bon trajet : sociabilisez facilement dans les transports en commun'],
      showCursor: false,
      typeSpeed: 30,
      loop: false,
      startDelay: 10
    })
  }
}
