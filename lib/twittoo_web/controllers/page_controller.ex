defmodule TwittooWeb.PageController do
  use TwittooWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
