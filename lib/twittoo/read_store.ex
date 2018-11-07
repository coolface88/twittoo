defmodule Twittoo.ReadStore do
  use GenServer, id: Twittoo.ReadStore
  require Logger

  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def new(msg) do
    GenServer.call(__MODULE__, {:new, msg})
  end

  def append(msg) do
    GenServer.call(__MODULE__, {:append, msg})
  end

  def count() do
    GenServer.call(__MODULE__, {:count})
  end

  ## Server Callbacks

  def init(:ok) do
    Logger.info "read store created"

    {:ok, []}
  end

  def handle_call(request, _from, list) do
    Logger.info "Twittoo.ReadStore::genserver handle_call callback in"
    case request do
      {:new, msg} ->
        {:reply, [] ++ msg, [] ++ msg}
      {:append, msg} ->
        {:reply, list ++ msg, list ++ msg}
      {:count} ->
        {:reply, Enum.count(list), list}
      {_,_} -> Logger.info "handle_call unmatched any cases"
    end
  end


end
