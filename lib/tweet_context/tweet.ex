defmodule TweetContext.Tweet do
  require UUID
  require Logger
  require DateTime

  def store_tweet(tweet) do
    Logger.info tweet
    uuid = UUID.uuid1()
    list = [msg: tweet, uuid: uuid]
    {status, result} = JSON.encode(list)
    Logger.info result
  end

  def timestamp do
    :os.system_time(:milli_seconds)
  end
end
