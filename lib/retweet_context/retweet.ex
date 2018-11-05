defmodule RetweetContext.Retweet do
  require UUID
  require Logger
  require DateTime
  alias Twittoo.Ets, as: Ets

  def retweet_counter(key) do
    t = {:update_counter, "number_of_retweet_kv", key}
    IO.inspect(Ets.put(t),[])
  end

end
