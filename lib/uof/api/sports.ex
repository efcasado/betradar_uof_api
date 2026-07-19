defmodule UOF.API.Sports do
  @moduledoc """
  Sports API.

  Covers the documented Sports HTTP endpoints: schedules (per-date, live,
  prematch and per-tournament), individual fixtures, fixture and result changes,
  sport-event summaries and timelines, the sport/category/tournament/season
  catalogue, and player/competitor/venue profiles.

  Every function returns `{:ok, struct} | {:error, UOF.API.Error.t()}`, where
  the struct is an `UOF.Schemas.API.Sports.*` embedded schema, takes an
  optional `lang` (ISO code, default `"en"`), and accepts a trailing `opts`
  keyword list merged into the Req request (see `UOF.API.Utils.HTTP`).

  For client-side conveniences over these endpoints — lazily streaming the full
  prematch catalogue and filtering sport events by `liveodds` booking state —
  see `UOF.API.Sports.Fixtures`.
  """
  alias UOF.API.Utils.HTTP

  @doc """
  Get the details of the given fixture.
  """
  def fixture(fixture, lang \\ "en", opts \\ []) do
    # TO-DO: handle codds fixture (eg. codds:competition_group:77739)
    endpoint = ["sports", lang, "sport_events", fixture, "fixture.xml"]

    HTTP.get(endpoint, [], opts)
  end

  @doc """
  Get a list of all the fixtures scheduled to start at the given date (in UTC).
  """
  def schedule(date, lang \\ "en", opts \\ []) do
    endpoint = ["sports", lang, "schedules", date, "schedule.xml"]

    HTTP.get(endpoint, [], opts)
  end

  @doc """
  Get a list of all live fixtures.
  """
  def live_schedule(lang \\ "en", opts \\ []) do
    endpoint = ["sports", lang, "schedules", "live", "schedule.xml"]

    HTTP.get(endpoint, [], opts)
  end

  @doc """
  Get a lists of almost all fixtures Betradar offers prematch odds for.
  """
  def pre_schedule(start \\ 0, limit \\ 100, lang \\ "en", opts \\ []) do
    endpoint = ["sports", lang, "schedules", "pre", "schedule.xml"]

    HTTP.get(endpoint, [start: start, limit: limit], opts)
  end

  @doc """
  Get the schedule of the given tournament.
  """
  def tournament_schedule(tournament, lang \\ "en", opts \\ []) do
    endpoint = ["sports", lang, "tournaments", tournament, "schedule.xml"]

    HTTP.get(endpoint, [], opts)
  end

  @doc """
  Get a list of all the fixtures that have changed.

  Defaults to changes in the last 24 hours. Pass `filters` to narrow the
  results:

    * `:after` - only return changes after this point in time (a `DateTime`,
      `NaiveDateTime`, or an already-formatted ISO8601 string). Use this to
      catch up on changes missed during downtime longer than 24 hours.
    * `:sport` - only return changes for the given sport urn (e.g.
      `"sr:sport:1"`).
  """
  def fixture_changes(lang \\ "en", filters \\ [], opts \\ []) do
    endpoint = ["sports", lang, "fixtures", "changes.xml"]

    HTTP.get(endpoint, changes_params(filters), opts)
  end

  @doc """
  Get a lists of all the fixtures that have changed results.

  Same optional `filters` as `fixture_changes/3`.
  """
  def result_changes(lang \\ "en", filters \\ [], opts \\ []) do
    endpoint = ["sports", lang, "results", "changes.xml"]

    HTTP.get(endpoint, changes_params(filters), opts)
  end

  defp changes_params(filters) do
    Enum.map(filters, fn
      {:after, %mod{} = datetime} when mod in [DateTime, NaiveDateTime] ->
        {:after, mod.to_iso8601(datetime)}

      {key, value} when key in [:after, :sport] ->
        {key, value}
    end)
  end

  ## Sport Event Information
  ## =========================================================================

  @doc """
  Get information and results for the given fixture.
  """
  def summary(fixture, lang \\ "en", opts \\ []) do
    # https://docs.betradar.com/display/BD/UOF+-+Summary+end+point
    # TO-DO: differentiate between match and race summaries
    endpoint = ["sports", lang, "sport_events", fixture, "summary.xml"]

    HTTP.get(endpoint, [], opts)
  end

  @doc """
  Get detailed information (including event timeline) for the given sport event.
  # Prematch, Live or Post-match. Prematch details are very brief. Post-match
  # details include results.
  """
  def timeline(fixture, lang \\ "en", opts \\ []) do
    endpoint = ["sports", lang, "sport_events", fixture, "timeline.xml"]

    HTTP.get(endpoint, [], opts)
  end

  @doc """
  List all the available sports.
  """
  def sports(lang \\ "en", opts \\ []) do
    endpoint = ["sports", lang, "sports.xml"]

    HTTP.get(endpoint, [], opts)
  end

  @doc """
  List all the available categories for the given sport.
  """
  def categories(sport, lang \\ "en", opts \\ []) do
    endpoint = ["sports", lang, "sports", sport, "categories.xml"]

    HTTP.get(endpoint, [], opts)
  end

  @doc """
  List all the tournaments for the given sport.
  """
  def sport_tournaments(sport, lang \\ "en", opts \\ []) do
    endpoint = ["sports", lang, "sports", sport, "tournaments.xml"]

    HTTP.get(endpoint, [], opts)
  end

  def tournaments(lang \\ "en", opts \\ []) do
    endpoint = ["sports", lang, "tournaments.xml"]

    HTTP.get(endpoint, [], opts)
  end

  @doc """
  Get details about the given tournament.
  """
  def tournament(tournament, lang \\ "en", opts \\ []) do
    # https://docs.betradar.com/display/BD/UOF+-+Tournament+we+provide+coverage+for
    endpoint = ["sports", lang, "tournaments", tournament, "info.xml"]

    # TO-DO: staged tournaments
    # https://docs.betradar.com/display/BD/UOF+-+Formula+1
    HTTP.get(endpoint, [], opts)
  end

  @doc """
  Get all the seasons of the given tournament.
  """
  def seasons(tournament, lang \\ "en", opts \\ []) do
    endpoint = ["sports", lang, "tournaments", tournament, "seasons.xml"]

    HTTP.get(endpoint, [], opts)
  end

  ## Entity Description
  ## =========================================================================
  @doc """
  Get the details of the given player.
  """
  def player(player, lang \\ "en", opts \\ []) do
    # https://docs.betradar.com/display/BD/UOF+-+Player+profile
    endpoint = ["sports", lang, "players", player, "profile.xml"]

    HTTP.get(endpoint, [], opts)
  end

  @doc """
  Get the details of the given competitor.
  """
  def competitor(competitor, lang \\ "en", opts \\ []) do
    # https://docs.betradar.com/display/BD/UOF+-+Competitors+profile
    endpoint = ["sports", lang, "competitors", competitor, "profile.xml"]

    HTTP.get(endpoint, [], opts)
  end

  @doc """
  Get the details of the given venue.
  """
  def venue(venue, lang \\ "en", opts \\ []) do
    # https://docs.betradar.com/display/BD/UOF+-+Venues
    endpoint = ["sports", lang, "venues", venue, "profile.xml"]

    HTTP.get(endpoint, [], opts)
  end
end
