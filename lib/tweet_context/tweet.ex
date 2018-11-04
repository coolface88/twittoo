defmodule TweetContext.Tweet do
  require Logger
  require DateTime
  alias Twittoo.Ets, as: Ets

  def store_tweet(tweet) do
    Logger.info "::TweeContext.Tweet.store_tweet "
    key = UUID.uuid1()
    t = {:insert, "tweet_kv", key, tweet}
    Ets.put(t)
    r = {:insert_counter, "number_of_retweet_kv", key, "0"}
    Ets.put(r)
    c = {:update_counter, "number_of_retweet_kv", key}
    Ets.put(c)
    d = {:update_counter, "number_of_retweet_kv", key}
    Ets.put(d)
    e = {:update_counter, "number_of_retweet_kv", key}
    Ets.put(e)
  end

end
