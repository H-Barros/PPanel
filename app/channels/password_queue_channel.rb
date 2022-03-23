class PasswordQueueChannel < ApplicationCable::Channel
  def subscribed
    stream_from "password_queue_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
