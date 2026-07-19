defmodule UOF.API.Sports.Test do
  use ExUnit.Case
  use Mimic

  alias UOF.API.Error
  alias UOF.API.Sports
  alias UOF.API.Sports.Fixtures
  alias UOF.API.Utils.HTTP
  alias UOF.Schemas.XML

  setup do
    stub(HTTP, :get, fn endpoint, _params, _opts ->
      {:ok, data} = fetch_mock_data(endpoint)
      XML.decode(data)
    end)

    :ok
  end

  defp fetch_mock_data(["sports", _lang, "sport_events", _fixture, "fixture.xml"]) do
    {:ok, File.read!("test/data/fixture.xml")}
  end

  defp fetch_mock_data(["sports", _lang, "fixtures", "changes.xml"]) do
    {:ok, File.read!("test/data/fixture_changes.xml")}
  end

  defp fetch_mock_data(["sports", _lang, "results", "changes.xml"]) do
    {:ok, File.read!("test/data/result_changes.xml")}
  end

  defp fetch_mock_data(["sports", _lang, "sport_events", _fixture, "summary.xml"]) do
    {:ok, File.read!("test/data/summary.xml")}
  end

  defp fetch_mock_data(["sports", _lang, "sport_events", _fixture, "timeline.xml"]) do
    {:ok, File.read!("test/data/timeline.xml")}
  end

  defp fetch_mock_data(["sports", _lang, "sports", _sport, "categories.xml"]) do
    {:ok, File.read!("test/data/categories.xml")}
  end

  defp fetch_mock_data(["sports", _lang, "tournaments.xml"]) do
    {:ok, File.read!("test/data/tournaments.xml")}
  end

  defp fetch_mock_data(["sports", _lang, "sports.xml"]) do
    {:ok, File.read!("test/data/sports.xml")}
  end

  defp fetch_mock_data(["sports", _lang, "tournaments", _tournament, "info.xml"]) do
    {:ok, File.read!("test/data/tournament_info.xml")}
  end

  defp fetch_mock_data(["sports", _lang, "players", _player, "profile.xml"]) do
    {:ok, File.read!("test/data/player_profile.xml")}
  end

  defp fetch_mock_data(["sports", _lang, "competitors", _competitor, "profile.xml"]) do
    {:ok, File.read!("test/data/competitor_profile.xml")}
  end

  defp fetch_mock_data(["sports", _lang, "venues", _venue, "profile.xml"]) do
    {:ok, File.read!("test/data/venue_profile.xml")}
  end

  defp fetch_mock_data(["sports", _lang, "sports", _sport, "tournaments.xml"]) do
    {:ok, File.read!("test/data/sport_tournaments.xml")}
  end

  defp fetch_mock_data(["sports", _lang, "tournaments", _tournament, "seasons.xml"]) do
    {:ok, File.read!("test/data/tournament_seasons.xml")}
  end

  defp fetch_mock_data(_endpoint) do
    {:error, "mock data not found"}
  end

  ## Static sport event information
  ## =========================================================================

  test "can parse UOF.API.Sports.fixture/{1, 2} response" do
    {:ok, ff} = Sports.fixture("sr:match:8696826")

    fixture = ff.fixture
    # fixture attributes
    assert fixture.liveodds == "not_available"
    assert fixture.status == "closed"
    assert fixture.next_live_time == "2016-10-31T18:00:00+00:00"
    assert fixture.id == "sr:match:8696826"
    assert fixture.scheduled == ~U[2016-10-31 18:00:00Z]
    assert fixture.start_time_tbd == false
    # tournament round
    assert fixture.tournament_round.type == "group"
    assert fixture.tournament_round.number == 25
    assert fixture.tournament_round.group_long_name == "Ettan, Sodra"
    assert fixture.tournament_round.betradar_name == "Ettan, Sodra"
    assert fixture.tournament_round.betradar_id == 4301
    # season
    assert fixture.season.start_date == ~D[2016-04-16]
    assert fixture.season.end_date == ~D[2016-11-05]
    assert fixture.season.year == "2016"
    assert fixture.season.tournament_id == "sr:tournament:68"
    assert fixture.season.id == "sr:season:12346"
    assert fixture.season.name == "Div 1, Sodra 2016"
    # tournament
    assert fixture.tournament.id == "sr:tournament:68"
    assert fixture.tournament.name == "Ettan, Sodra"
    assert fixture.tournament.sport.id == "sr:sport:1"
    assert fixture.tournament.sport.name == "Soccer"
    assert fixture.tournament.category.id == "sr:category:9"
    assert fixture.tournament.category.name == "Sweden"
    # competitors
    [competitor1, competitor2] = fixture.competitors.competitor
    assert competitor1.qualifier == "home"
    assert competitor1.id == "sr:competitor:1860"
    assert competitor1.name == "IK Oddevold"
    assert competitor1.abbreviation == "ODD"
    assert competitor1.short_name == "Oddevold"
    assert competitor1.country == "Sweden"
    assert competitor1.country_code == "SWE"
    assert competitor1.gender == "male"
    assert competitor2.qualifier == "away"
    assert competitor2.id == "sr:competitor:22356"
    assert competitor2.name == "Tvaakers IF"
    assert competitor2.abbreviation == "TVA"
    assert competitor2.short_name == "Tvaakers"
    assert competitor2.country == "Sweden"
    assert competitor2.country_code == "SWE"
    assert competitor2.gender == "male"
    # extra info
    [info1, info2, info3, info4, info5, info6, info7] = fixture.extra_info.info
    assert info1.key == "RTS"
    assert info1.value == "not_available"
    assert info2.key == "coverage_source"
    assert info2.value == "venue"
    assert info3.key == "extended_live_markets_offered"
    assert info3.value == "false"
    assert info4.key == "streaming"
    assert info4.value == "false"
    assert info5.key == "auto_traded"
    assert info5.value == "false"
    assert info6.key == "neutral_ground"
    assert info6.value == "false"
    assert info7.key == "period_length"
    assert info7.value == "45"
    # reference ids
    [reference] = fixture.reference_ids.reference_id
    assert reference.name == "BetradarCtrl"
    assert reference.value == "11428313"
  end

  # The fixture endpoint is polymorphic: querying a season/tournament id returns
  # a <tournament_info> document rather than <fixtures_fixture>. Dispatching on
  # the root element must surface it as a TournamentInfoEndpoint instead of a
  # hollow FixturesEndpoint.
  test "fixture/2 on a season id returns the tournament_info document" do
    stub(HTTP, :get, fn ["sports", _lang, "sport_events", _id, "fixture.xml"], _params, _opts ->
      XML.decode(File.read!("test/data/tournament_info.xml"))
    end)

    assert {:ok, %UOF.Schemas.API.Sports.TournamentInfoEndpoint{} = info} =
             Sports.fixture("sr:season:101177")

    assert info.tournament.id == "sr:tournament:7"
  end

  test "can parse UOF.API.Sports.fixture_changes/{0, 1} response" do
    {:ok, data} = Sports.fixture_changes()

    change = hd(data.fixture_change)

    assert Enum.count(data.fixture_change) == 9543
    assert change.sport_event_id == "sr:match:49540297"
    assert change.update_time == ~U[2024-04-26 19:12:43Z]
  end

  test "can parse UOF.API.Sports.result_changes/{0, 1} response" do
    {:ok, data} = Sports.result_changes()

    change = hd(data.result_change)

    assert Enum.count(data.result_change) == 4236
    assert change.sport_event_id == "sr:match:49689671"
    assert change.update_time == ~U[2024-04-26 19:12:56Z]
  end

  test "stream/0 paginates the prematch schedule and aggregates events" do
    page = File.read!("test/data/schedule.xml")

    stub(HTTP, :get, fn _endpoint, params, _opts ->
      data = if Keyword.get(params, :start, 0) == 0, do: page, else: "<schedule/>"
      XML.decode(data)
    end)

    events = Enum.to_list(Fixtures.stream())

    assert length(events) == 4

    assert events |> Enum.map(& &1.id) |> Enum.sort() ==
             ["sr:match:1", "sr:match:2", "sr:match:3", "sr:match:4"]
  end

  test "stream/0 raises API errors while enumerating" do
    error = %Error{type: :http, status: 503, message: "UOF API returned HTTP 503"}

    stub(HTTP, :get, fn _endpoint, _params, _opts -> {:error, error} end)

    assert_raise Error, "UOF API returned HTTP 503", fn ->
      Enum.to_list(Fixtures.stream())
    end
  end

  test "filters a schedule by liveodds booking state" do
    {:ok, schedule} =
      XML.decode(
        File.read!("test/data/schedule.xml"),
        UOF.Schemas.API.Sports.ScheduleEndpoint
      )

    assert Enum.map(Fixtures.bookable(schedule), & &1.id) == ["sr:match:1"]
    assert Enum.map(Fixtures.booked(schedule), & &1.id) == ["sr:match:2"]
    assert Enum.map(Fixtures.buyable(schedule), & &1.id) == ["sr:match:3"]

    assert Enum.map(Fixtures.with_liveodds(schedule, "not_available"), & &1.id) ==
             [
               "sr:match:4"
             ]
  end

  ## Sport event information
  ## =========================================================================
  test "can parse 'sports/:lang/sport_events/:fixture/summary.xml' response" do
    {:ok, summary} = Sports.summary("sr:match:42308595")

    sport_event = summary.sport_event
    # sport event
    assert sport_event.id == "sr:match:42308595"
    assert sport_event.scheduled == ~U[2024-04-26 17:30:00Z]
    assert sport_event.start_time_tbd == false
    # sport event -> tournament round
    assert sport_event.tournament_round.type == "group"
    assert sport_event.tournament_round.number == 30
    assert sport_event.tournament_round.group_long_name == "2nd Bundesliga"
    assert sport_event.tournament_round.betradar_name == "2nd Bundesliga"
    assert sport_event.tournament_round.betradar_id == 16_956
    # sport event -> season
    assert sport_event.season.start_date == ~D[2023-09-01]
    assert sport_event.season.end_date == ~D[2024-06-01]
    assert sport_event.season.year == "23/24"
    assert sport_event.season.tournament_id == "sr:tournament:921"
    assert sport_event.season.id == "sr:season:107905"
    assert sport_event.season.name == "2. HBL 23/24"
    # sport event -> tournament
    assert sport_event.tournament.id == "sr:tournament:921"
    assert sport_event.tournament.name == "2. HBL"
    assert sport_event.tournament.sport.id == "sr:sport:6"
    assert sport_event.tournament.sport.name == "Handball"
    assert sport_event.tournament.category.id == "sr:category:53"
    assert sport_event.tournament.category.name == "Germany"
    # sport event -> competitors
    [competitor1, competitor2] = sport_event.competitors.competitor
    assert competitor1.qualifier == "home"
    assert competitor1.id == "sr:competitor:6325"
    assert competitor1.name == "VfL Eintracht Hagen"
    assert competitor1.abbreviation == "HAG"
    assert competitor1.short_name == "Eintracht Hagen"
    assert competitor1.country == "Germany"
    assert competitor1.country_code == "DEU"
    assert competitor1.gender == "male"
    [c1_ref] = competitor1.reference_ids.reference_id
    assert c1_ref.name == "betradar"
    assert c1_ref.value == "8042520"
    assert competitor2.qualifier == "away"
    assert competitor2.id == "sr:competitor:7808"
    assert competitor2.name == "HC Elbflorenz 2006"
    assert competitor2.abbreviation == "ELB"
    assert competitor2.short_name == "Elbflorenz 2006"
    assert competitor2.country == "Germany"
    assert competitor2.country_code == "DEU"
    assert competitor2.gender == "male"
    [c2_ref] = competitor2.reference_ids.reference_id
    assert c2_ref.name == "betradar"
    assert c2_ref.value == "9919108"
    # sport event -> venue
    assert sport_event.venue.id == "sr:venue:7072"
    assert sport_event.venue.name == "Ischelandhalle"
    assert sport_event.venue.capacity == 1200
    assert sport_event.venue.city_name == "Hagen"
    assert sport_event.venue.country_name == "Germany"
    assert sport_event.venue.country_code == "DEU"
    assert sport_event.venue.map_coordinates == "51.370987,7.477113"
    # event conditions
    assert summary.sport_event_conditions.attendance == "1054"
    assert summary.sport_event_conditions.venue.id == "sr:venue:7072"
    assert summary.sport_event_conditions.venue.name == "Ischelandhalle"
    assert summary.sport_event_conditions.venue.capacity == 1200
    # event status
    assert summary.sport_event_status.home_score == "30"
    assert summary.sport_event_status.away_score == "31"
    assert summary.sport_event_status.status_code == 4
    assert summary.sport_event_status.match_status_code == 100
    assert summary.sport_event_status.status == "closed"
    assert summary.sport_event_status.match_status == "ended"
    assert summary.sport_event_status.winner_id == "sr:competitor:7808"
    # event status -> period scores
    [period1, period2] = summary.sport_event_status.period_scores.period_score
    assert period1.home_score == 13
    assert period1.away_score == 16
    assert period1.type == "regular_period"
    assert period1.number == 1
    assert period2.home_score == 17
    assert period2.away_score == 15
    assert period2.number == 2
    # event status -> results
    [result] = summary.sport_event_status.results.result
    assert result.home_score == "30"
    assert result.away_score == "31"
    assert result.match_status_code == 100
    # coverage info
    assert summary.coverage_info.level == "silver"
    assert summary.coverage_info.live_coverage == true
    assert summary.coverage_info.covered_from == "venue"

    assert Enum.map(summary.coverage_info.coverage, & &1.includes) == [
             "basic_score",
             "key_events"
           ]
  end

  test "can parse UOF.API.Sports.timeline/{1, 2} response" do
    {:ok, timeline} = Sports.timeline("sr:match:42308595")

    sport_event = timeline.sport_event
    assert sport_event.id == "sr:match:42308595"
    assert sport_event.scheduled == ~U[2024-04-26 17:30:00Z]
    assert sport_event.tournament.sport.name == "Handball"

    # events
    events = timeline.timeline.event
    assert Enum.count(events) == 70

    match_started_event = Enum.find(events, &(&1.type == "match_started"))
    assert match_started_event.id == 1_731_284_211
    assert match_started_event.time == ~U[2024-04-26 17:33:59Z]

    period_start_event = Enum.find(events, &(&1.type == "period_start"))
    assert period_start_event.id == 1_731_284_217
    assert period_start_event.period_name == "1st half"
    assert period_start_event.period == "1"

    score_change_event = Enum.find(events, &(&1.type == "score_change"))
    assert score_change_event.match_time == 2
    assert score_change_event.match_clock == "1:12"
    assert score_change_event.team == "away"
    assert score_change_event.home_score == "0"
    assert score_change_event.away_score == "1"
    assert score_change_event.goal_scorer.id == "sr:player:1341258"
    assert score_change_event.goal_scorer.name == "Pehlivan, Doruk"
    [assist] = score_change_event.assist
    assert assist.type == "primary"
    assert assist.id == "sr:player:1554873"
    assert assist.name == "Grzesinski, Mats"

    yellow_card_event = Enum.find(events, &(&1.type == "yellow_card"))
    assert yellow_card_event.team == "away"
    assert yellow_card_event.player.id == "sr:player:211672"
    assert yellow_card_event.player.name == "Thummler, Jonas"

    match_ended_event = Enum.find(events, &(&1.type == "match_ended"))
    assert match_ended_event.id == 1_731_393_345
    assert match_ended_event.match_clock == "60:00"
  end

  test "can parse UOF.API.Sports.categories/{1, 2} response" do
    {:ok, sport_categories} = Sports.categories("sr:sport:1")

    # sport
    sport = sport_categories.sport
    assert sport.id == "sr:sport:1"
    assert sport.name == "Soccer"
    # categories
    categories = sport_categories.categories.category
    category = hd(categories)
    assert Enum.count(categories) == 224
    assert category.id == "sr:category:1"
    assert category.name == "England"
    assert category.country_code == "ENG"
  end

  test "can parse UOF.API.Sports.tournaments/{0, 1} response" do
    {:ok, data} = Sports.tournaments()

    tournament = Enum.at(data.tournament, 2)

    # tournament attributes
    assert Enum.count(data.tournament) == 1312
    assert tournament.id == "sr:tournament:7"
    assert tournament.name == "UEFA Champions League"
    # tournament -> sport
    assert tournament.sport.id == "sr:sport:1"
    assert tournament.sport.name == "Soccer"
    # tournament -> category
    assert tournament.category.id == "sr:category:393"
    assert tournament.category.name == "International Clubs"
    # tournament -> current season
    assert tournament.current_season.year == "23/24"
    assert tournament.current_season.id == "sr:season:106479"
    # tournament -> season coverage
    assert tournament.season_coverage_info.season_id == "sr:season:106479"
    assert tournament.season_coverage_info.scheduled == 215
    assert tournament.season_coverage_info.played == 210
    assert tournament.season_coverage_info.max_covered == 136
    assert tournament.season_coverage_info.max_coverage_level == "gold"
    assert tournament.season_coverage_info.min_coverage_level == "silver"
  end

  test "can parse UOF.API.Sports.sports/{0, 1} response" do
    {:ok, data} = Sports.sports()

    sport = hd(data.sport)

    assert Enum.count(data.sport) == 204
    assert sport.id == "sr:sport:143"
    assert sport.name == "7BallRun"
  end

  test "can parse UOF.API.Sports.tournament/{1, 2} response" do
    {:ok, info} = Sports.tournament("sr:tournament:7")

    # tournament
    assert info.tournament.id == "sr:tournament:7"
    assert info.tournament.name == "UEFA Champions League"
    assert info.tournament.sport.id == "sr:sport:1"
    assert info.tournament.sport.name == "Soccer"
    assert info.tournament.category.id == "sr:category:393"
    assert info.tournament.category.name == "International Clubs"
    # season
    assert info.season.year == "23/24"
    assert info.season.id == "sr:season:106479"
    assert info.season.name == "UEFA Champions League 23/24"
    # round
    assert info.round.type == "cup"
    assert info.round.name == "Quarterfinal"
    assert info.round.cup_round_matches == 2
    assert info.round.cup_round_match_number == 2
    # coverage info
    assert info.coverage_info.live_coverage == "true"
    # groups
    group = hd(info.groups.group)
    assert Enum.count(info.groups.group) == 9
    assert group.name == "A"
    assert group.id == "sr:group:74525"
    # group -> competitors
    competitor = hd(group.competitor)
    assert Enum.count(group.competitor) == 4
    assert competitor.id == "sr:competitor:2672"
    assert competitor.name == "Bayern Munich"
    assert competitor.abbreviation == "BMU"
    assert competitor.country == "Germany"
    assert competitor.country_code == "DEU"
    assert competitor.gender == "male"
    [reference] = competitor.reference_ids.reference_id
    assert reference.name == "betradar"
    assert reference.value == "6631"
  end

  test "can parse UOF.API.Sports.sport_tournaments/{1, 2} response" do
    {:ok, data} = Sports.sport_tournaments("sr:sport:1")

    assert data.sport.id == "sr:sport:1"
    assert data.sport.name == "Soccer"

    [tournament] = data.tournaments.tournament
    assert tournament.id == "sr:tournament:7"
    assert tournament.name == "UEFA Champions League"
  end

  test "can parse UOF.API.Sports.seasons/{1, 2} response" do
    {:ok, data} = Sports.seasons("sr:tournament:7")

    assert data.tournament.id == "sr:tournament:7"

    [season] = data.seasons.season
    assert season.id == "sr:season:106479"
    assert season.name == "UEFA Champions League 23/24"
  end

  ## Entity descriptions
  ## =========================================================================
  test "can parse UOF.API.Sports.player/{1, 2} response" do
    {:ok, profile} = Sports.player("sr:player:72771")

    assert profile.player.date_of_birth == "1973-08-29"
    assert profile.player.nationality == "Germany"
    assert profile.player.country_code == "DEU"
    assert profile.player.full_name == "Thomas Tuchel"
    assert profile.player.gender == "male"
    assert profile.player.id == "sr:player:72771"
    assert profile.player.name == "Tuchel, Thomas"
  end

  test "can parse UOF.API.Sports.competitor/{1, 2} response" do
    {:ok, profile} = Sports.competitor("sr:competitor:2672")

    # competitor
    assert profile.competitor.id == "sr:competitor:2672"
    assert profile.competitor.name == "Bayern Munich"
    assert profile.competitor.abbreviation == "BMU"
    assert profile.competitor.country == "Germany"
    assert profile.competitor.country_code == "DEU"
    assert profile.competitor.gender == "male"
    # competitor -> sport
    assert profile.competitor.sport.id == "sr:sport:1"
    assert profile.competitor.sport.name == "Soccer"
    # competitor -> category
    assert profile.competitor.category.id == "sr:category:30"
    assert profile.competitor.category.name == "Germany"
    assert profile.competitor.category.country_code == "DEU"
    # venue
    assert profile.venue.id == "sr:venue:574"
    assert profile.venue.name == "Allianz Arena"
    assert profile.venue.capacity == 75_000
    assert profile.venue.city_name == "Munich"
    assert profile.venue.country_name == "Germany"
    assert profile.venue.country_code == "DEU"
    assert profile.venue.map_coordinates == "48.218777,11.624748"
    # jerseys
    jersey = hd(profile.jerseys.jersey)
    assert Enum.count(profile.jerseys.jersey) == 4
    assert jersey.type == "home"
    assert jersey.base == "fdfcfc"
    assert jersey.sleeve == "ff0000"
    assert jersey.number == "f90606"
    assert jersey.stripes == false
    assert jersey.horizontal_stripes == false
    assert jersey.squares == false
    assert jersey.split == false
    assert jersey.shirt_type == "short_sleeves"
    # manager
    assert profile.manager.id == "sr:player:72771"
    assert profile.manager.name == "Tuchel, Thomas"
    assert profile.manager.nationality == "Germany"
    assert profile.manager.country_code == "DEU"
    # players
    player = hd(profile.players.player)
    assert Enum.count(profile.players.player) == 32
    assert player.type == "goalkeeper"
    assert player.date_of_birth == "1986-03-27"
    assert player.nationality == "Germany"
    assert player.country_code == "DEU"
    assert player.height == 193
    assert player.weight == 93
    assert player.jersey_number == 1
    assert player.full_name == "Manuel Peter Neuer"
    assert player.gender == "male"
    assert player.id == "sr:player:8959"
    assert player.name == "Neuer, Manuel"
  end

  test "can parse UOF.API.Sports.venue/{1, 2} response" do
    {:ok, profile} = Sports.venue("sr:venue:574")

    # venue
    assert profile.venue.id == "sr:venue:574"
    assert profile.venue.name == "Allianz Arena"
    assert profile.venue.capacity == 75_000
    assert profile.venue.city_name == "Munich"
    assert profile.venue.country_name == "Germany"
    assert profile.venue.country_code == "DEU"
    assert profile.venue.map_coordinates == "48.218777,11.624748"
    # home teams
    home_team = hd(profile.home_teams.competitor)
    assert Enum.count(profile.home_teams.competitor) == 1
    assert home_team.id == "sr:competitor:2672"
    assert home_team.name == "Bayern Munich"
    assert home_team.abbreviation == "BMU"
    assert home_team.country == "Germany"
    assert home_team.country_code == "DEU"
    assert home_team.gender == "male"
  end
end
