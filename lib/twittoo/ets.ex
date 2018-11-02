defmodule Twittoo.Ets do
  use GenServer, id: Twittoo.Ets
  require Logger

  ## Server
  def init(state) do
    :ets.new(:tweet_kv, [:set, :named_table, :public])
    Logger.info "tweet_kv created"
    :ets.new(:number_of_retweet_kv, [:set, :named_table, :public])
    Logger.info "number_of_retweet_kv created"
    {:ok, state}
  end

  def start_link(args) do
    #:ets.new(:tweet_table, [:set, :named_table, :public])
    GenServer.start_link(__MODULE__, args, name: __MODULE__)
    Logger.info "ets process started"
  end

  def handle_call(request, _from, _state) do
    Logger.info "ets insert request"
    {:noreply, :ets.insert(:tweet_table, {request})}
  end

  def put(msg) do
    GenServer.call(__MODULE__, msg)
  end

end
