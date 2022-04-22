defmodule WebhookGen.Impl.LoggingSink do
  use GenServer

  def start_link(_state) do
    GenServer.start_link(__MODULE__, nil, name: LoggingSink)
  end

  ## Callbacks

  @impl true
  def init(_state) do
    {:ok, nil}
  end

  @impl true
  def handle_cast({:webhook_event, payload}, _state) do
    IO.puts(payload)
    {:noreply, nil}
  end
end
