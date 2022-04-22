defmodule WebhookGen.Runtime.Application do
  use Application

  def start(_type, _args) do
    children = [
      WebhookGen.Impl.LoggingSink
    ]

    opts = [strategy: :one_for_one, name: WebhookGen.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
