defmodule WebhookGen.Runtime.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: WebhookGen.Worker.start_link(arg)
      # {WebhookGen.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: WebhookGen.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
