defmodule Suum.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Suum.Repo,
      # Start the Telemetry supervisor
      SuumWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Suum.PubSub},
      # Start the Endpoint (http/https)
      SuumWeb.Presence,
      SuumWeb.Endpoint
      # SuumWeb.Stun
      # Start a worker by calling: Suum.Worker.start_link(arg)
      # {Suum.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Suum.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    SuumWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
