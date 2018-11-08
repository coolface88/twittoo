defmodule TwittooWeb.PageController do
  use TwittooWeb, :controller
  alias Twittoo.SessionStore, as: SessionStore

  def index(conn, _params) do
    #render conn, "index.html"
    SessionStore.new(0)
    #text conn, body
    render conn, "index.html"
  end

end
