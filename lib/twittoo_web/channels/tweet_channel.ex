defmodule TwittooWeb.TweetChannel do
  use Phoenix.Channel
  alias TweetContext.Tweet, as: Tweet
  require Logger

  def join("tweet:", _message, socket) do
    {:ok, socket}
  end
#  def join("room:" <> _private_room_id, _params, _socket) do
#    {:error, %{reason: "unauthorized"}}
#  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    Logger.info  "Logging this text"
    Tweet.store_tweet body
    broadcast! socket, "new_msg", %{body: body}
    response = Phoenix.View.render(TwittooWeb.TweetView, "tweetsnippet.html")
    #response = %{body => "hung hahahahaha"}
    #{:reply, {:ok, response}, socket}
  end
end
