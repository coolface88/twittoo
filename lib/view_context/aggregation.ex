defmodule ViewContext.Aggregation do
  alias TweetContext.Tweet, as: Tweet
  alias RetweetContext.Retweet, as: Retweet

  def get_top_ten_retweet() do
    result = Tweet.sort_tweet()
    Enum.take(result,10)
  end

end
