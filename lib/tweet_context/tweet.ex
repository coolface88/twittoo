defmodule TweetContext.Tweet do
  require Logger
  alias Twittoo.Ets, as: Ets
  alias Twittoo.ReadStore, as: Read
  alias Twittoo.SessionStore, as: SessionStore
  alias ViewContext.Aggregation, as: Aggregation

  def store_tweet(tweet) do
    Logger.info "::TweeContext.Tweet.store_tweet "
    key1 = UUID.uuid1()

    t = {:insert, "tweet_kv", key1, tweet}
    IO.inspect(Ets.put(t), [])
    r = {:insert_counter, "number_of_retweet_kv", key1, "0"}
    IO.inspect(Ets.put(r),[])

    matchspec = [{{:"$1",:"$2"}, [], [:"$_"]}]
    select = {:select, "tweet_kv", matchspec}
    IO.inspect(Ets.put(select),[])

    matchspec = [{{:"$1",:"$2"}, [], [:"$_"]}]
    select = {:select, "number_of_retweet_kv", matchspec}
    Ets.put(select) |> IO.inspect

    SessionStore.get_current_page |> IO.inspect

    list = Aggregation.get_top_ten() |> IO.inspect


  end

  def count() do
    matchspec = [{{:"$1",:"$2"}, [], [:"$_"]}]
    select = {:select_count, "number_of_retweet_kv", matchspec}
    Ets.put(select) |> IO.inspect
  end

  def get_all() do
    matchspec = [{{:"$1",:"$2"}, [], [:"$_"]}]
    select = {:select, "tweet_kv", matchspec}
    IO.inspect(Ets.put(select),[])
  end

  def lookup_tweet(key) do
    l = {:lookup, "tweet_kv", key}
    IO.inspect(Ets.put(l),[])
  end

end
