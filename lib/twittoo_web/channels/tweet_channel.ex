defmodule TwittooWeb.TweetChannel do
  use Phoenix.Channel
  alias TweetContext.Tweet, as: Tweet
  require Logger
  alias Twittoo.SessionStore, as: SessionStore

  def join("tweet:", _message, socket) do
    {:ok, socket}
  end
#  def join("room:" <> _private_room_id, _params, _socket) do
#    {:error, %{reason: "unauthorized"}}
#  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    Logger.info  "Logging this text"
    Tweet.store_tweet body



    SessionStore.new(4) |> IO.inspect
    broadcast! socket, "new_msg", %{body: body}
    #response = Phoenix.View.render(TwittooWeb.TweetView, "tweetsnippet.html", %{})
    #response = %{body => "hung hahahahaha"}
    #{:reply, {:ok, response}, socket}

    {:noreply, socket}
  end

  def handle_in("new_num_page", %{"body" => body}, socket) do
    Logger.info  "new num page"
    broadcast! socket, "abc", %{body: body}
    #response = Phoenix.View.render(TwittooWeb.TweetView, "tweetsnippet.html", %{})
    #response = %{body => "hung hahahahaha"}
    #{:reply, {:ok, response}, socket}
    {:noreply, socket}
  end
end
