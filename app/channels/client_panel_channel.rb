class ClientPanelChannel < ApplicationCable::Channel
  def subscribed
    stream_from "client_panel_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
