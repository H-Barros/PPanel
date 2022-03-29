import consumer from "./consumer"

consumer.subscriptions.create("AttendanceChannel", {
  connected() {
    console.log("Connected WS")
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    const password_queue_button = document.getElementById("password_queue_button")
    const password_queue_badge = document.getElementById("password_queue_badge")

    if (data.passwords_in_queue > 0) {
      password_queue_button.classList.remove("btn-danger")
      password_queue_button.classList.contains("btn-primary") ? "" : password_queue_button.classList.add("btn-primary")
      password_queue_badge.innerHTML = data.passwords_in_queue
    } else {
      password_queue_button.classList.remove("btn-primary")
      password_queue_button.classList.contains("btn-danger") ? "" : password_queue_button.classList.add("btn-danger")
      password_queue_badge.innerHTML = data.passwords_in_queue
    }
  }
});
