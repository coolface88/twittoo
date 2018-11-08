defmodule TwittooWeb.DisplayChannel do
  use Phoenix.Channel
  require Logger

  def join("display:", _message, socket) do
    {:ok, socket}
  end
#  def join("room:" <> _private_room_id, _params, _socket) do
#    {:error, %{reason: "unauthorized"}}
#  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    Logger.info  "Logging this text"
    broadcast! socket, "new_msg", %{body: body}
    #response = Phoenix.View.render(TwittooWeb.TweetView, "tweetsnippet.html", %{})
    #response = %{body => "hung hahahahaha"}
    #{:reply, {:ok, response}, socket}
    {:noreply, socket}
  end
end
