defmodule TweetContext.Tweet do
  require Logger
  alias Twittoo.Ets, as: Ets

  def store_tweet(tweet) do
    Logger.info "::TweeContext.Tweet.store_tweet "
    key1 = UUID.uuid1()
    key2 = UUID.uuid1()
    key3 = UUID.uuid1()

    key4 = UUID.uuid1()
    key5 = UUID.uuid1()
    key6 = UUID.uuid1()
    t = {:insert, "tweet_kv", key1, tweet}
    IO.inspect(Ets.put(t), [])
    t = {:insert, "tweet_kv", key2, "hung agag agga"}
    IO.inspect(Ets.put(t), [])
    t = {:insert, "tweet_kv", key3, "hung agag aggasdfsdfsdfs"}
    IO.inspect(Ets.put(t), [])
    t = {:insert, "tweet_kv", key4, "hung agag sddsfsfdsfsdgdfgddgfdgd"}
    IO.inspect(Ets.put(t), [])
    t = {:insert, "tweet_kv", key5, "hung shdjsdfjsd jfsjhf shdfvshd fhsgdvfhs fd agga"}
    IO.inspect(Ets.put(t), [])
    t = {:insert, "tweet_kv", key6, "hung agag agga sdsfsgdf ashfvsd shfvhs shfg fsdhfhs sfdhsgdf"}
    IO.inspect(Ets.put(t), [])

    r = {:insert_counter, "number_of_retweet_kv", key1, "0"}
    IO.inspect(Ets.put(r),[])
    r = {:insert_counter, "number_of_retweet_kv", key2, "0"}
    IO.inspect(Ets.put(r),[])
    r = {:insert_counter, "number_of_retweet_kv", key3, "0"}
    IO.inspect(Ets.put(r),[])
    c1 = {:update_counter, "number_of_retweet_kv", key1}
    IO.inspect(Ets.put(c1),[])
    IO.inspect(Ets.put(c1),[])
    IO.inspect(Ets.put(c1),[])

    c2 = {:update_counter, "number_of_retweet_kv", key2}
    IO.inspect(Ets.put(c2),[])
    IO.inspect(Ets.put(c2),[])
    IO.inspect(Ets.put(c2),[])
    IO.inspect(Ets.put(c2),[])
    IO.inspect(Ets.put(c2),[])

    l = {:lookup, "number_of_retweet_kv", key1}
    IO.inspect(Ets.put(l),[])
    l = {:lookup, "number_of_retweet_kv", key2}
    IO.inspect(Ets.put(l),[])
    l = {:lookup, "number_of_retweet_kv", key3}
    IO.inspect(Ets.put(l),[])

    matchspec = [{{:"$1",:"$2"}, [], [:"$_"]}]
    select = {:select, "number_of_retweet_kv", matchspec}
    IO.inspect(Ets.put(select),[])

    sort_tweet()

  end

  def sort_tweet() do
    matchspec = [{{:"$1",:"$2"}, [], [:"$_"]}]
    select = {:select, "number_of_retweet_kv", matchspec}
    result = Ets.put(select)
    sorted = Enum.sort_by(result, &elem(&1,1), &>=/2)
    IO.inspect(sorted,[])
    keys = Enum.flat_map(sorted, fn x -> [elem(x,0)] end)
    IO.inspect(Enum.flat_map(keys, fn x -> Ets.put({:select, "tweet_kv", [{{x,:"$2"}, [], [:"$_"]}]}) end))
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
