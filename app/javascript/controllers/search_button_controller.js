import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-button"
export default class extends Controller {
  static targets = ["submit", 'input']
  connect() {
    console.log('hello Robin');
  }

  displaySearchBar(event) {
    event.preventDefault()
    console.log(event.currentTarget, this.submitTarget) // trigger
    this.submitTarget.classList.remove("d-none")
    this.submitTarget.classList.add("btn-search-navbar")
    this.inputTarget.classList.add("input-search-navbar-display")
  }
}
