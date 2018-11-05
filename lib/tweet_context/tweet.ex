defmodule TweetContext.Tweet do
  require Logger
  require DateTime
  alias Twittoo.Ets, as: Ets

  def store_tweet(tweet) do
    Logger.info "::TweeContext.Tweet.store_tweet "
    key = UUID.uuid1()
    t = {:insert, "tweet_kv", key, tweet}
    IO.inspect(Ets.put(t), [])
    r = {:insert_counter, "number_of_retweet_kv", key, "0"}
    IO.inspect(Ets.put(r),[])
    c = {:update_counter, "number_of_retweet_kv", key}
    IO.inspect(Ets.put(c),[])
    IO.inspect(Ets.put(c),[])
    IO.inspect(Ets.put(c),[])
    l = {:lookup, "tweet_kv", key}
    IO.inspect(Ets.put(l),[])

  end

end
