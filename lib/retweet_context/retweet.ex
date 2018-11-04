defmodule RetweetContext.Retweet do
  require UUID
  require Logger
  require DateTime
  alias Twittoo.Ets, as: Ets

  def increase_retweet_counter(key) do
    t = {:update_counter, "number_of_retweet_kv", key}
    Ets.put(t)
    c = {:update_counter, "number_of_retweet_kv", key}
    Ets.put(c)
    d = {:update_counter, "number_of_retweet_kv", key}
    Ets.put(d)
    e = {:update_counter, "number_of_retweet_kv", key}
    Ets.put(e)
  end

end
