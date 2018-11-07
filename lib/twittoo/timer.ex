defmodule Twittoo.Timer do
  use GenServer, id: Twittoo.Timer
  alias TweetContext.Tweet, as: Tweet
  alias Twittoo.ReadStore, as: ReadStore
  require Logger

  def start_link(_opts) do
    Logger.info "timer initiated"
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def reset_timer() do
    GenServer.call(__MODULE__, :reset_timer)
  end

  def init(:ok) do
    Logger.info "timer armed for 60 sec"
    timer = Process.send_after(self(), :sort_the_tweet, 60_000)
    {:ok, %{timer: timer}}
  end

  def handle_call(:reset_timer, _from, %{timer: timer}) do
    :timer.cancel(timer)
    timer = Process.send_after(self(), :sort_the_tweet, 60_000)
    {:reply, :ok, %{timer: timer}}
  end

  def handle_info(:sort_the_tweet, _state) do
    # Do the work you desire here
    Logger.info "The tweets sorting process is triggered and then update the read store of view aggregation every 60sec"
    result = Tweet.sort_tweet()
    ReadStore.new(result)
    # Start the timer again
    timer = Process.send_after(self(), :sort_the_tweet, 60_000)

    {:noreply, %{timer: timer}}
  end

  # So that unhanded messages don't error
  def handle_info(_, %{timer: timer}) do
    {:ok, %{timer: timer}}
  end
end
