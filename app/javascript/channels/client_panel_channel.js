import consumer from "./consumer"

consumer.subscriptions.create("ClientPanelChannel", {
  connected() {
    console.log("connected on WS")
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    const next_password_number = document.getElementById("next_password_number")
    const next_password_guiche = document.getElementById("next_password_guiche")
    const previous_passwords = document.getElementById("previous_passwords")

    previous_passwords.innerHTML = ""

    next_password_number.innerHTML = data.next_password.number == undefined ? "???" : data.next_password.number
    next_password_guiche.innerHTML = data.next_password.desk == undefined ? "???" : data.next_password.desk

    for(let i = 0; i < data.passwords.length; i++){
      if (data.passwords[i].number != data.next_password.number) {
        const previous_password_div = document.createElement("div")
        previous_password_div.classList.add("mb-2")
        previous_password_div.innerHTML = `Senha:${data.passwords[i].number} + <p>Guiche:${data.passwords[i].desk}</p>`
        previous_passwords.appendChild(previous_password_div)
      }
    }

    console.log(data)
  }
});
