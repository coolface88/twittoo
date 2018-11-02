defmodule Twittoo.Ets do
  use GenServer, id: Twittoo.Ets
  require Logger

  ## Server
  def init(stack) do
    :ets.new(:tweet_table, [:set, :named_table, :public])
    Logger.info "tweet_table created"
    :ets.new(:retweet_table, [:set, :named_table, :public])
    Logger.info "retweet_table created"
    {:ok, stack}
  end

  def start_link(state) do
    #:ets.new(:tweet_table, [:set, :named_table, :public])
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
    Logger.info "ets process started"
  end

  def handle_call(request, _from, _state) do
    :ets.insert(:tweet_table, {request})
  end

  def put(msg) do
    GenServer.call(MyEts, msg)
  end

end
