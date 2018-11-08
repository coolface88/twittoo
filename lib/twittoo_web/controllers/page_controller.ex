defmodule TwittooWeb.PageController do
  use TwittooWeb, :controller
  alias Twittoo.SessionStore, as: SessionStore
  alias ViewContext.Aggregation, as: Aggregation

  def index(conn, _params) do
    # This is a very simple session to store current page state.
    # Cookies / Session plug cannot cope with socket and http connection contxt combined
    SessionStore.new(0)
    
    render conn, "index.html"
  end

end
