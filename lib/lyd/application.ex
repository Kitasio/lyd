defmodule Lyd.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      LydWeb.Telemetry,
      # Start the Ecto repository
      Lyd.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Lyd.PubSub},
      # Start Finch
      {Finch, name: Lyd.Finch},
      # Start the Endpoint (http/https)
      LydWeb.Endpoint
      # Start a worker by calling: Lyd.Worker.start_link(arg)
      # {Lyd.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Lyd.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LydWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
