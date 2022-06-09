import { Controller } from "@hotwired/stimulus"
import { CountUp } from 'countup.js'

// Connects to data-controller="countup"
export default class extends Controller {
  static targets = ["score"]

  connect() {
    let score_target = this.scoreTarget.innerText
    const countUp = new CountUp('score-global', score_target, {
      duration: 3
    })
    countUp.start()
  }
}
