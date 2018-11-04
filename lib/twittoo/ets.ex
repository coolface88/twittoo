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
      {:insert, table, key, msg} ->
        {:reply, {self(), :tweet}, insert(table, key, msg)}
      {:insert_counter, table, key, msg} ->
        {:reply, {self(), :tweet}, insert_counter(table, key, msg)}
      {:lookup, table, key} ->
        {:reply, {self(), :tweet}, lookup(table, key)}
      {:update_counter, table, key} ->
        {:reply, {self(), :tweet}, update_counter(table, key)}
      {_,_} -> Logger.info "handle_call unmatched any cases"
    end
  end

  defp update_counter(table, key) do
    :ets.update_counter(String.to_atom(table), key, {2,1})
    Logger.info "genserver handle_call -> ets:update_counter into " <>table<> " table with key:" <> key
    [{asd, val}] = :ets.lookup(String.to_atom(table), key)
    Logger.info "result increased " <> Integer.to_string(val)
  end

  defp insert_counter(table, key, msg) do
    :ets.insert(String.to_atom(table), {key, String.to_integer(msg)})
    Logger.info "genserver handle_call -> ets:insert into " <>table<> " table with key:value " <> key <> " : " <> msg
  end

  defp insert(table, key, msg) do
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
