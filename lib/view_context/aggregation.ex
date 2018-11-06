defmodule ViewContext.Aggregation do
  alias TweetContext.Tweet, as: Tweet
  alias RetweetContext.Retweet, as: Retweet

  def get_top_ten_retweet() do
    result = Retweet.get_all
    sorted = Retweet.retweet_sort_by(result)
    keys = Enum.flat_map(sorted, fn x -> [elem(x,0)] end)
    ten = Enum.take(keys,10)
    Enum.flat_map(ten, fn x -> Ets.put({:select, "tweet_kv", [{{x,:"$2"}, [], [:"$_"]}]}) end)
  end



end
