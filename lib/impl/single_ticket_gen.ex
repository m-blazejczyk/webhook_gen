defmodule WebhookGen.Impl.SingleTicketGen do
  @type args :: %{time_scale: integer(), event_sink: pid()}
  @type e :: {sleep_minutes :: integer(), payload :: any()}

  @spec start(args(), list(e())) :: pid | {pid, reference}
  def start(args, events) do
    Process.spawn(__MODULE__, :generate, [args, events], [])
  end

  @spec generate(args(), list(e())) :: true
  def generate(
        args = %{time_scale: time_scale, event_sink: sink},
        [{sleep, payload} | remaining_events]
      ) do
    Process.sleep(div(sleep * 1000 * 60, time_scale))
    send(sink, {:webhook_event, payload})
    generate(args, remaining_events)
  end

  def generate(_args, []) do
    Process.exit(self(), {:shutdown, :ticket_closed})
  end

  # Included only for testing purposes
  def sink_fun() do
    receive do
      {:webhook_event, payload} ->
        IO.puts(payload)
        sink_fun()
    end
  end
end
