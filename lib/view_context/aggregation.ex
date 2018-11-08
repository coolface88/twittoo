defmodule ViewContext.Aggregation do
  alias RetweetContext.Retweet, as: Retweet
  alias TweetContext.Tweet, as: Tweet
  alias Twittoo.ReadStore, as: ReadStore
  alias Twittoo.Ets, as: Ets

  def sort_tweet() do
    keys = Retweet.retweet_sort_by_value()
    list = Enum.flat_map(keys, fn x -> Ets.put({:select, "tweet_kv", [{{x,:"$2"}, [], [:"$_"]}]}) end)
  end

  def get_top_ten() do
    result = sort_tweet()
    list = Enum.take(result, 10)
    Enum.into(list,%{})
  end

  def count_num_tweets() do
    Tweet.count()
  end

  def get_tweet_page(index) do
    ReadStore.page(index)
  end

  def count_num_page() do
    numtweet = div(count_num_tweets(), 10)
    if rem(count_num_tweets(), 10) > 0 do
      numtweet + 1
    else
      numtweet
    end
  end

end
