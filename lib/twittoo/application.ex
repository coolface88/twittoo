defmodule Twittoo.Application do
  use Application
  require Logger
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised

    SessionSup.start_link([])
    SessionSup.start_child

    DynamicSup.start_link([])
    DynamicSup.start_child

    ViewSup.start_link([])
    ViewSup.start_child

    children = [
      # Start the Ecto repository
      supervisor(Twittoo.Repo, []),
      # Start the endpoint when the application starts
      supervisor(TwittooWeb.Endpoint, []),
      # Start your own worker by calling: Twittoo.Worker.start_link(arg1, arg2, arg3)
      #worker(Twittoo.Ets, []),
      #%{
      #  id: Twittoo.Ets,
      #  start: {Twittoo.Ets, :start_link, [[:hello]]},
      # }
    ]

    #Twittoo.Ets.start_link()
    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Twittoo.Supervisor]
    Supervisor.start_link(children, opts)
    #Twittoo.Ets.start_link

    TimeSup.start_link([])
    TimeSup.start_child

  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    TwittooWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
