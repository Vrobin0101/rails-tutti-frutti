import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-button"
export default class extends Controller {
  static targets = ["submit", 'input']
  connect() {
  }

  displaySearchBar(event) {
    event.preventDefault()
    this.submitTarget.classList.remove("d-none")
    this.submitTarget.classList.add("btn-search-navbar")
    this.inputTarget.classList.add("input-search-navbar-display")
    this.inputTarget.focus()
  }

  closeSearchBar() {
    this.submitTarget.classList.add("d-none")
    this.submitTarget.classList.remove("btn-search-navbar")
    this.inputTarget.classList.remove("input-search-navbar-display")
  }
}
