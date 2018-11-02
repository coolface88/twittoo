defmodule Twittoo.MySupervisor do
  # Automatically defines child_spec/1
  use Supervisor

  def start_link(arg) do
    Supervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  @impl true
  def init(_arg) do
    children = [
      {Twittoo.Ets, [:hello]}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
