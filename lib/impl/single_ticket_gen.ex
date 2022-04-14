defmodule WebhookGen.Impl.SingleTicketGen do
  @type t :: {sleep_minutes :: integer(), payload :: String.t()}

  @spec start(list(t()), integer) :: pid | {pid, reference}
  def start(events, time_scale) do
    Process.spawn(__MODULE__, :generate, [events, time_scale], [])
  end

  @spec generate(list(t()), integer) :: true
  def generate([{sleep, payload} | remaining_events], time_scale) do
    Process.sleep(div(sleep * 1000 * 60, time_scale))
    IO.puts(payload)
    generate(remaining_events, time_scale)
  end

  def generate([], _time_scale) do
    Process.exit(self(), {:shutdown, :ticket_closed})
  end
end
