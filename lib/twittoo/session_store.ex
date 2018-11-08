defmodule Twittoo.SessionStore do
  use GenServer, id: Twittoo.SessionStore
  require Logger

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def new(msg) do
    GenServer.call(__MODULE__, {:new, msg})
  end

  def get_current_page() do
    GenServer.call(__MODULE__, {:get})
  end

  ## Server Callbacks

  def init(:ok) do
    Logger.info "session store created"
    {:ok, []}
  end

  def handle_call(request, _from, list) do
    Logger.info "Twittoo.SessionStore::genserver handle_call callback in"
    case request do
      {:new, msg} ->
        {:reply, [] ++ msg, [] ++ msg}
      {:get} ->
        {:reply, list, list}
      {_,_} -> Logger.info "handle_call unmatched any cases"
    end
  end

end
