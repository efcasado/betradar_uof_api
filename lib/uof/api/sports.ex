defmodule UOF.API.Sports do
  @moduledoc """
  Sports API.

  Covers the documented Sports HTTP endpoints: schedules (per-date, live,
  prematch and per-tournament), individual fixtures, fixture and result changes,
  sport-event summaries and timelines, the sport/category/tournament/season
  catalogue, and player/competitor/venue profiles.

  Every function returns `{:ok, struct} | {:error, Ecto.Changeset.t()}`, where
  the struct is an `UOF.Schemas.API.Sports.*` embedded schema, and takes an
  optional `lang` (ISO code, default `"en"`).

  For client-side conveniences over these endpoints — lazily streaming the full
  prematch catalogue and filtering sport events by `liveodds` booking state —
  see `UOF.API.Sports.Fixtures`.
  """
  alias UOF.API.Utils.HTTP

  @doc """
  Get the details of the given fixture.
  """
  def fixture(fixture, lang \\ "en") do
    # TO-DO: handle codds fixture (eg. codds:competition_group:77739)
    endpoint = ["sports", lang, "sport_events", fixture, "fixture.xml"]

    HTTP.get(endpoint)
  end

  @doc """
  Get a list of all the fixtures scheduled to start at the given date (in UTC).
  """
  def schedule(date, lang \\ "en") do
    endpoint = ["sports", lang, "schedules", date, "schedule.xml"]

    HTTP.get(endpoint)
  end

  @doc """
  Get a list of all live fixtures.
  """
  def live_schedule(lang \\ "en") do
    endpoint = ["sports", lang, "schedules", "live", "schedule.xml"]

    HTTP.get(endpoint)
  end

  @doc """
  Get a lists of almost all fixtures Betradar offers prematch odds for.
  """
  def pre_schedule(start \\ 0, limit \\ 100, lang \\ "en") do
    endpoint = ["sports", lang, "schedules", "pre", "schedule.xml"]

    HTTP.get(endpoint, start: start, limit: limit)
  end

  @doc """
  Get the schedule of the given tournament.
  """
  def tournament_schedule(tournament, lang \\ "en") do
    endpoint = ["sports", lang, "tournaments", tournament, "schedule.xml"]

    HTTP.get(endpoint)
  end

  @doc """
  Get a list of all the fixtures that have changed in the last 24 hours.
  """
  def fixture_changes(lang \\ "en") do
    # TO-DO: add support for 'after datetime' and 'sport' filters
    endpoint = ["sports", lang, "fixtures", "changes.xml"]

    HTTP.get(endpoint)
  end

  @doc """
  Get a lists of all the fixtures that have changed results in the last 24 hours.
  """
  def result_changes(lang \\ "en") do
    # TO-DO: add support for 'after datetime' and 'sport' filters
    endpoint = ["sports", lang, "results", "changes.xml"]

    HTTP.get(endpoint)
  end

  ## Sport Event Information
  ## =========================================================================

  @doc """
  Get information and results for the given fixture.
  """
  def summary(fixture, lang \\ "en") do
    # https://docs.betradar.com/display/BD/UOF+-+Summary+end+point
    # TO-DO: differentiate between match and race summaries
    endpoint = ["sports", lang, "sport_events", fixture, "summary.xml"]

    HTTP.get(endpoint)
  end

  @doc """
  Get detailed information (including event timeline) for the given sport event.
  # Prematch, Live or Post-match. Prematch details are very brief. Post-match
  # details include results.
  """
  def timeline(fixture, lang \\ "en") do
    endpoint = ["sports", lang, "sport_events", fixture, "timeline.xml"]

    HTTP.get(endpoint)
  end

  @doc """
  List all the available sports.
  """
  def sports(lang \\ "en") do
    endpoint = ["sports", lang, "sports.xml"]

    HTTP.get(endpoint)
  end

  @doc """
  List all the available categories for the given sport.
  """
  def categories(sport, lang \\ "en") do
    endpoint = ["sports", lang, "sports", sport, "categories.xml"]

    HTTP.get(endpoint)
  end

  @doc """
  List all the tournaments for the given sport.
  """
  def sport_tournaments(sport, lang \\ "en") do
    endpoint = ["sports", lang, "sports", sport, "tournaments.xml"]

    HTTP.get(endpoint)
  end

  def tournaments(lang \\ "en") do
    endpoint = ["sports", lang, "tournaments.xml"]

    HTTP.get(endpoint)
  end

  @doc """
  Get details about the given tournament.
  """
  def tournament(tournament, lang \\ "en") do
    # https://docs.betradar.com/display/BD/UOF+-+Tournament+we+provide+coverage+for
    endpoint = ["sports", lang, "tournaments", tournament, "info.xml"]

    # TO-DO: staged tournaments
    # https://docs.betradar.com/display/BD/UOF+-+Formula+1
    HTTP.get(endpoint)
  end

  @doc """
  Get all the seasons of the given tournament.
  """
  def seasons(tournament, lang \\ "en") do
    endpoint = ["sports", lang, "tournaments", tournament, "seasons.xml"]

    HTTP.get(endpoint)
  end

  ## Entity Description
  ## =========================================================================
  @doc """
  Get the details of the given player.
  """
  def player(player, lang \\ "en") do
    # https://docs.betradar.com/display/BD/UOF+-+Player+profile
    endpoint = ["sports", lang, "players", player, "profile.xml"]

    HTTP.get(endpoint)
  end

  @doc """
  Get the details of the given competitor.
  """
  def competitor(competitor, lang \\ "en") do
    # https://docs.betradar.com/display/BD/UOF+-+Competitors+profile
    endpoint = ["sports", lang, "competitors", competitor, "profile.xml"]

    HTTP.get(endpoint)
  end

  @doc """
  Get the details of the given venue.
  """
  def venue(venue, lang \\ "en") do
    # https://docs.betradar.com/display/BD/UOF+-+Venues
    endpoint = ["sports", lang, "venues", venue, "profile.xml"]

    HTTP.get(endpoint)
  end
end
