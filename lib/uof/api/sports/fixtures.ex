defmodule UOF.API.Sports.Fixtures do
  @moduledoc """
  Client-side helpers over the Sports schedule endpoints: collecting fixtures
  across the paginated prematch schedule, and filtering sport events by their
  `liveodds` booking state.

  These compose over the raw endpoints in `UOF.API.Sports`.
  """
  alias UOF.API.Sports

  @page_size 1000

  @doc """
  Lazily stream every fixture Betradar offers prematch odds for.

  Pages of the prematch schedule are fetched on demand, so this composes with
  `Stream`/`Enum` and supports early termination:

      Sports.Fixtures.stream() |> Stream.map(& &1.id) |> Enum.take(50)

  API errors are raised when the stream is enumerated.
  """
  def stream(lang \\ "en") do
    Stream.resource(
      fn -> 0 end,
      fn start ->
        case Sports.pre_schedule(start, @page_size, lang) do
          {:ok, %{sport_event: []}} -> {:halt, start}
          {:ok, %{sport_event: events}} -> {events, start + @page_size}
          {:error, error} -> raise error
        end
      end,
      fn _ -> :ok end
    )
  end

  @doc """
  Stream fixtures restricted to the given sport name(s).
  """
  def by_sport(sports, lang \\ "en")

  def by_sport(sports, lang) when is_list(sports) do
    lang |> stream() |> Stream.filter(&(&1.tournament.sport.name in sports))
  end

  def by_sport(sport, lang), do: by_sport([sport], lang)

  ## Booking-state filters
  ## =========================================================================

  @doc """
  Filter a schedule's sport events by their `liveodds` booking state (e.g.
  `"bookable"`, `"booked"`, `"buyable"`, `"not_available"`).

  Accepts a schedule struct (such as the one returned by `UOF.API.Sports.schedule/2`)
  or a plain list of sport events. The state values are not enumerated by the
  schema, so prefer this for any value beyond the named shortcuts below.
  """
  def with_liveodds(%{sport_event: events}, state), do: with_liveodds(events, state)

  def with_liveodds(events, state) when is_list(events) do
    Enum.filter(events, &(&1.liveodds == state))
  end

  @doc "Sport events that can be booked for live odds."
  def bookable(schedule), do: with_liveodds(schedule, "bookable")

  @doc "Sport events already booked for live odds."
  def booked(schedule), do: with_liveodds(schedule, "booked")

  @doc "Sport events available to buy."
  def buyable(schedule), do: with_liveodds(schedule, "buyable")
end
