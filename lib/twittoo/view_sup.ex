defmodule ViewSup do
  use DynamicSupervisor

  def start_link(arg) do
    DynamicSupervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  def start_child do
    # If MyWorker is not using the new child specs, we need to pass a map:
    spec = %{id: Twittoo.ReadStore, start: {Twittoo.ReadStore, :start_link, []}}
    #spec = {MyWorker, foo: foo, bar: bar, baz: baz}
    DynamicSupervisor.start_child(__MODULE__, spec)

  end

  @impl true
  def init(initial_arg) do
    DynamicSupervisor.init(
      strategy: :one_for_one,
      extra_arguments: [initial_arg]
    )
  end
end
