defmodule TweetContext.Tweet do
  require UUID
  require Logger
  require DateTime
  alias Storage.TweetData, as: Data

  def store_tweet(tweet) do
    Logger.info tweet
    uuid = UUID.uuid1()
    list = [msg: tweet, uuid: uuid]
    {status, result} = JSON.encode(list)
    Logger.info result
    t = {uuid,tweet}
    Data.put(t)

  end

  def timestamp do
    :os.system_time(:milli_seconds)
  end
end
