defmodule SocketGallows.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {Phoenix.PubSub, name: SocketGallows.PubSub},
      SocketGallowsWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: SocketGallows.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    SocketGallowsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
