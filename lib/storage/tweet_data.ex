defmodule Storage.TweetData do
  require Logger
  alias Twittoo.Ets, as: Ets

  def new() do
    Map.new()
  end

  def get(map, key) do
    Map.get(map,key)
  end

  def values(map) do
    Map.values(map)
  end

  def put(t) do
    #:ets.new(:tweet_table, [:set, :named_table, :public])
    #:ets.insert(:tweet_table, t)
    Ets.put(t)
  end

  defstruct uuid: "195d974a-dd85-11e8-ba0a-14109fe66b9b", msg: "labalabalaa"

end
