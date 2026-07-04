defmodule UOF.API.Booking do
  @moduledoc """
  Booking Calendar API.

  Booking makes a sport event available for live odds. The HTTP response is only
  an acknowledgement (`UOF.Schemas.Common.Response`).

  There are no GET endpoints for the booking calendar — booking state is exposed
  on schedule responses via the `liveodds` attribute (`"booked"`, `"bookable"`,
  `"buyable"`, `"not_available"`). Filter a schedule by that state with the
  `liveodds` helpers in `UOF.API.Sports.Fixtures` (e.g.
  `UOF.API.Sports.Fixtures.bookable/1`).
  """
  alias UOF.API.Utils.HTTP

  @doc """
  Book the given `sport_event` (e.g. `"sr:match:12345"`) for live odds.
  """
  def book(sport_event) do
    endpoint = ["liveodds", "booking-calendar", "events", sport_event, "book"]
    HTTP.post(endpoint)
  end
end
