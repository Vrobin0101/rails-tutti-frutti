import { Controller } from "@hotwired/stimulus"
import { CountUp } from 'countup.js'

// Connects to data-controller="countup"
export default class extends Controller {
  static targets = ["scoreMonth"]

  connect() {
    let score_target = this.scoreMonthTarget.innerText
    const countUp = new CountUp('score-month', score_target, {
      duration: 3
    })
    countUp.start()
  }
}
