defmodule Twittoo.Ets do
  use GenServer, id: Twittoo.Ets
  require Logger
  require UUID

  ## Server
  def init(state) do
    :ets.new(:tweet_kv, [:ordered_set, :named_table, :public])
    Logger.info "tweet_kv created"
    :ets.new(:number_of_retweet_kv, [:ordered_set, :named_table, :public])
    Logger.info "number_of_retweet_kv created"

    key1 = UUID.uuid1()
    key2 = UUID.uuid1()
    key3 = UUID.uuid1()
    key4 = UUID.uuid1()
    key5 = UUID.uuid1()
    key6 = UUID.uuid1()

    :ets.insert(:tweet_kv, {key1, "Dolorem aspernatur rerum, iure? Culpa iste aperiam sequi, fuga, quasi rerum, eum, quo natus tenetur officia placeat."})
    :ets.insert(:tweet_kv, {key2, "Dolorem aspernatur rerum, iure? Culpa iste aperiam sequi, fuga, quasi rerum, eum, quo natus tenetur officia placeat."})
    :ets.insert(:tweet_kv, {key3, "Dolorem aspernatur rerum, iure? Culpa iste aperiam sequi, fuga, quasi rerum, eum, quo natus tenetur officia placeat."})
    :ets.insert(:tweet_kv, {key4, "Dolorem aspernatur rerum, iure? Culpa iste aperiam sequi, fuga, quasi rerum, eum, quo natus tenetur officia placeat."})
    :ets.insert(:tweet_kv, {key5, "Dolorem aspernatur rerum, iure? Culpa iste aperiam sequi, fuga, quasi rerum, eum, quo natus tenetur officia placeat."})
    :ets.insert(:tweet_kv, {key6, "Dolorem aspernatur rerum, iure? Culpa iste aperiam sequi, fuga, quasi rerum, eum, quo natus tenetur officia placeat."})

    :ets.insert(:number_of_retweet_kv, {key1, 0})
    :ets.insert(:number_of_retweet_kv, {key2, 5})
    :ets.insert(:number_of_retweet_kv, {key3, 97})
    :ets.insert(:number_of_retweet_kv, {key4, 3})
    :ets.insert(:number_of_retweet_kv, {key5, 1})
    :ets.insert(:number_of_retweet_kv, {key6, 85})

    {:ok, state}
  end

  def start_link(args) do
    #:ets.new(:tweet_table, [:set, :named_table, :public])
    GenServer.start_link(__MODULE__, args, name: __MODULE__)
    Logger.info "ets process started"
  end

  def handle_call(request, _from, _state) do
    Logger.info "Twittoo.Ets::genserver handle_call callback in"

    case request do
      {:insert, table, key, msg} ->
        {:reply, insert(table, key, msg), :inserting}
      {:insert_counter, table, key, msg} ->
        {:reply, insert_counter(table, key, msg), :inserting}
      {:lookup, table, key} ->
        {:reply, lookup(table, key), :looking_up}
      {:update_counter, table, key} ->
        {:reply, update_counter(table, key), :updating}
      {:select, table, matchspec} ->
        {:reply, select(table, matchspec), :selecting}
      {:select_limit, table, matchspec, limit} ->
        {:reply, select_limit(table, matchspec, limit), :limit_selecting}
      {:select_count, table, matchspec} ->
        {:reply, select_count(table, matchspec), :count_selecting}
      {_,_} -> Logger.info "handle_call unmatched any cases"
    end
  end

  defp update_counter(table, key) do
    Logger.info "genserver handle_call -> ets:update_counter from "<>table<>" table with key:"<>key
    :ets.update_counter(String.to_atom(table), key, {2,1})
  end

  defp insert_counter(table, key, msg) do
    Logger.info "genserver handle_call -> ets:insert from "<>table<>" table with key:value "<>key<>" : "<>msg
    :ets.insert(String.to_atom(table), {key, String.to_integer(msg)})
  end

  defp insert(table, key, msg) do
    Logger.info "genserver handle_call -> ets:insert from "<>table<>" table with key:value "<>key<>" : "<>msg
    :ets.insert(String.to_atom(table), {key, msg})
  end

  defp lookup(table, key) do
    Logger.info "genserver handle_call -> ets:lookup from "<>table<>" table with key: "<>key
    :ets.lookup(String.to_atom(table), key)
  end

  defp select(table, matchspec) do
    Logger.info "genserver handle_call -> ets:select/2 from " <>table<> " table with match_spec "
    :ets.select(String.to_atom(table), matchspec)
  end

  defp select_count(table, matchspec) do
    Logger.info "genserver handle_call -> ets:select_count/2 from " <>table<> " table with match_spec "
    :ets.select_count(String.to_atom(table), matchspec)
  end

  defp select_limit(table, matchspec, limit) do
    Logger.info "genserver handle_call -> ets:select_limit/3 from "<>table<>" table with match_spec "
    :ets.select(String.to_atom(table), matchspec, String.to_integer(limit))
  end

  def put(msg) do
    GenServer.call(__MODULE__, msg)
  end

end
