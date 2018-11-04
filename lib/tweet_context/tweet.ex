defmodule TweetContext.Tweet do
  require Logger
  require DateTime
  alias Twittoo.Ets, as: Ets

  def store_tweet(tweet) do
    Logger.info "::TweeContext.Tweet.store_tweet "
    t = {:insert, "tweet_kv", tweet}
    Ets.put(t)
    b = {:insert, "number_of_retweet_kv", tweet}
    Ets.put(b)
  end

end
