defmodule LiveMapTest.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      LiveMapTestWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: LiveMapTest.PubSub},
      # Start Finch
      {Finch, name: LiveMapTest.Finch},
      # Start the Endpoint (http/https)
      LiveMapTestWeb.Endpoint
      # Start a worker by calling: LiveMapTest.Worker.start_link(arg)
      # {LiveMapTest.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LiveMapTest.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LiveMapTestWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
