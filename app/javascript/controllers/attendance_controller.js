import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="attendance"
export default class extends Controller {
  static targets = [ "password", "sector", "service" ]
  
  async call() {
    const response = await fetch("http://localhost:3000/nextpassword")
    const password = await response.json()

    if (password.number == undefined) {
      this.passwordTarget.innerHTML = "Indisponível"
      this.sectorTarget.innerHTML = "???"
      this.serviceTarget.innerHTML = "???"
    } else {
      this.passwordTarget.innerHTML = password.number
      this.sectorTarget.innerHTML = password.sector
      this.serviceTarget.innerHTML = password.service
    }
  }
}
