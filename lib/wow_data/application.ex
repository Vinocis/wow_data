defmodule WoWData.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      WoWData.Repo,
      # Start the Telemetry supervisor
      WoWDataWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: WoWData.PubSub},
      # Start the Endpoint (http/https)
      WoWDataWeb.Endpoint
      # Start a worker by calling: WoWData.Worker.start_link(arg)
      # {WoWData.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: WoWData.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    WoWDataWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
