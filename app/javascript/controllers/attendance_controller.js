import { Controller } from "@hotwired/stimulus"
import { end } from "@popperjs/core"

const baseUrl = "http://localhost:3000"

// Connects to data-controller="attendance"
export default class extends Controller {
  static targets = [ "password", "sector", "service", "id" ]
  
  async call() {
    const response = await fetch(`${baseUrl}/nextpassword`)
    const password = await response.json()

    if (password.number == undefined) {
      this.passwordTarget.innerHTML = "Senhas indisponíveis para atendimento"
      this.sectorTarget.innerHTML = "???"
      this.serviceTarget.innerHTML = "???"
      this.idTarget.innerHTML = "Undefined"
    } else {
      this.passwordTarget.innerHTML = password.number
      this.sectorTarget.innerHTML = password.sector
      this.serviceTarget.innerHTML = password.service
      this.idTarget.innerHTML = password.id
    }
  }

  async end() {
    const password_id = this.idTarget.innerHTML

    if(this.idTarget.innerHTML == "Undefined") {
      this.passwordTarget.innerHTML = "Por favor chame uma senha primeiro!"
      this.sectorTarget.innerHTML = "???"
      this.serviceTarget.innerHTML = "???"
    } else {
    const response = await fetch(`${baseUrl}/endpassword/${password_id}`)
    const end_password = await response.json()

    this.passwordTarget.innerHTML = end_password.message
    this.sectorTarget.innerHTML = "???"
    this.serviceTarget.innerHTML = "???"
    this.idTarget.innerHTML = "Undefined"
    }
  }

  async cancel() {
    const password_id = this.idTarget.innerHTML

    if(this.idTarget.innerHTML == "Undefined") {
      this.passwordTarget.innerHTML = "Por favor chame uma senha primeiro!"
      this.sectorTarget.innerHTML = "???"
      this.serviceTarget.innerHTML = "???"
    } else {
    const response = await fetch(`${baseUrl}/cancelpassword/${password_id}`)
    const end_password = await response.json()

    this.passwordTarget.innerHTML = end_password.message
    this.sectorTarget.innerHTML = "???"
    this.serviceTarget.innerHTML = "???"
    this.idTarget.innerHTML = "Undefined"
    }
  }
}
