defmodule RetweetContext.Retweet do
  require UUID
  require Logger
  require DateTime
  alias Twittoo.Ets, as: Ets

  def store_tweet(tweet) do
    Logger.info tweet
    uuid = UUID.uuid1()
    list = [msg: tweet, uuid: uuid]
    result = JSON.encode(list)
    t = {uuid,tweet}
    Ets.put(t)

  end

end
