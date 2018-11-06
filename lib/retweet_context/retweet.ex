defmodule RetweetContext.Retweet do
  require UUID
  require Logger
  require DateTime
  alias Twittoo.Ets, as: Ets

  def retweet_counter(key) do
    t = {:update_counter, "number_of_retweet_kv", key}
    IO.inspect(Ets.put(t),[])
  end

  def retweet_sort_by(result) do
    sorted = Enum.sort_by(result, &elem(&1,1), &>=/2)
    Enum.flat_map(sorted, fn x -> [elem(x,0)] end)
  end

  def get_all() do
    matchspec = [{{:"$1",:"$2"}, [], [:"$_"]}]
    select = {:select, "number_of_retweet_kv", matchspec}
    IO.inspect(Ets.put(select),[])
  end



end
