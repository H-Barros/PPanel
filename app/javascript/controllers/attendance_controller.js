import { Controller } from "@hotwired/stimulus"
import { end } from "@popperjs/core"

const baseUrl = "http://localhost:3000"

// Connects to data-controller="attendance"
export default class extends Controller {
  static targets = [ "password", "sector", "service", "id", "guicheName", "inputName", "editIcon", "confirmIcon", "callButton", "recallButton" ]
  
  async call() {
    const response = await fetch(`${baseUrl}/nextpassword?desk=${this.guicheNameTarget.innerHTML}`)
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
      this.callButtonTarget.classList.contains("d-none") ? "" : this.callButtonTarget.classList.add("d-none")
      this.recallButtonTarget.classList.contains("d-none") ? this.recallButtonTarget.classList.remove("d-none") : ""
    }
  }

  async recall() {
    const response = await fetch(`${baseUrl}/recallpassword/${this.idTarget.innerHTML}`)
    const password = await response.json()

    this.passwordTarget.innerHTML = password.number
    this.sectorTarget.innerHTML = password.sector
    this.serviceTarget.innerHTML = password.service
    this.idTarget.innerHTML = password.id
  }

  async end() {
    const password_id = this.idTarget.innerHTML

    if(this.idTarget.innerHTML == "Undefined") {
      this.passwordTarget.innerHTML = "Por favor chame uma senha primeiro!"
      this.sectorTarget.innerHTML = "???"
      this.serviceTarget.innerHTML = "???"
      this.callButtonTarget.classList.contains("d-none") ? this.callButtonTarget.classList.remove("d-none") : ""
      this.recallButtonTarget.classList.contains("d-none") ? "" : this.recallButtonTarget.classList.add("d-none")
    } else {
      const response = await fetch(`${baseUrl}/endpassword/${password_id}`)
      const end_password = await response.json()

      this.passwordTarget.innerHTML = end_password.message
      this.sectorTarget.innerHTML = "???"
      this.serviceTarget.innerHTML = "???"
      this.idTarget.innerHTML = "Undefined"
      this.callButtonTarget.classList.contains("d-none") ? this.callButtonTarget.classList.remove("d-none") : ""
      this.recallButtonTarget.classList.contains("d-none") ? "" : this.recallButtonTarget.classList.add("d-none")
    }
  }

  async cancel() {
    const password_id = this.idTarget.innerHTML

    if(this.idTarget.innerHTML == "Undefined") {
      this.passwordTarget.innerHTML = "Por favor chame uma senha primeiro!"
      this.sectorTarget.innerHTML = "???"
      this.serviceTarget.innerHTML = "???"
      this.callButtonTarget.classList.contains("d-none") ? this.callButtonTarget.classList.remove("d-none") : ""
      this.recallButtonTarget.classList.contains("d-none") ? "" : this.recallButtonTarget.classList.add("d-none")
    } else {
      const response = await fetch(`${baseUrl}/cancelpassword/${password_id}`)
      const end_password = await response.json()

      this.passwordTarget.innerHTML = end_password.message
      this.sectorTarget.innerHTML = "???"
      this.serviceTarget.innerHTML = "???"
      this.idTarget.innerHTML = "Undefined"
      this.callButtonTarget.classList.contains("d-none") ? this.callButtonTarget.classList.remove("d-none") : ""
      this.recallButtonTarget.classList.contains("d-none") ? "" : this.recallButtonTarget.classList.add("d-none")
    }
  }

  edit_box_name(event) {
    event.preventDefault()

    this.guicheNameTarget.classList.add("d-none")
    this.inputNameTarget.classList.remove("d-none")
    this.editIconTarget.classList.add("d-none")
    this.confirmIconTarget.classList.remove("d-none")
  }

  confirm_box_name(event) {
    event.preventDefault()

    this.guicheNameTarget.innerHTML = this.inputNameTarget.value
    this.guicheNameTarget.classList.remove("d-none")
    this.inputNameTarget.classList.add("d-none")
    this.editIconTarget.classList.remove("d-none")
    this.confirmIconTarget.classList.add("d-none")
  }
}
