defmodule Twittoo.Ets do
  use GenServer, id: Twittoo.Ets
  require Logger
  require UUID

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
    Logger.info "genserver handle_call callback in"
    case request do
      {:insert, table, msg} ->
        {:reply, {self(), :tweet}, insert(table, msg)}
      {:lookup, table, key} ->
        {:reply, {self(), :tweet}, lookup(table, key)}
      {_,_} -> Logger.info "handle_call unmatched any cases"
    end
  end

  defp insert(table, msg) do
    key = UUID.uuid1()
    :ets.insert(String.to_atom(table), {key, msg})
    Logger.info "genserver handle_call -> ets:insert into " <>table<> " table with key:value " <> key <> " : " <> msg
  end

  defp lookup(table, key) do
    :ets.lookup(String.to_atom(table), key)
    Logger.info "genserver handle_call -> ets:lookup into " <>table<> " table with key: " <> key
  end

  def put(msg) do
    GenServer.call(__MODULE__, msg)
  end

end
