defmodule TwittooWeb.TweetView do
  use TwittooWeb, :view

  def render("show.json", %{user: user}) do
    %{name: user.name, address: user.address}
  end
end
