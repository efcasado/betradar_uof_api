defmodule UOF.API.Descriptions.Test do
  use ExUnit.Case
  use Mimic

  setup do
    stub(UOF.API.Utils.HTTP, :get, fn endpoint, _params, _opts ->
      data = File.read!("test/data/" <> Enum.at(endpoint, -1))
      UOF.Schemas.XML.decode(data)
    end)

    :ok
  end

  test "can parse UOF.API.Descriptions.markets/{0, 1} response" do
    {:ok, desc} = UOF.API.Descriptions.markets()

    market = hd(desc.market)

    assert Enum.count(desc.market) == 1172
    assert market.id == 282
    assert market.name == "Innings 1 to 5th top - {$competitor1} total"
    assert market.groups == "all|score|4.5_innings"
    assert Enum.map(market.outcomes.outcome, & &1.id) == ["13", "12"]
  end

  test "can parse UOF.API.Descriptions.match_statuses/{0, 1} response" do
    {:ok, desc} = UOF.API.Descriptions.match_statuses()

    assert Enum.count(desc.match_status) == 185

    status1 = Enum.at(desc.match_status, 0)

    assert status1.id == 0
    assert status1.description == "Not started"
    assert status1.period_number == nil
    assert status1.sports.all == true
    assert status1.sports.sport == []

    status2 = Enum.at(desc.match_status, 1)

    assert status2.id == 1
    assert status2.description == "1st period"
    assert status2.period_number == 1

    assert Enum.map(status2.sports.sport, & &1.id) ==
             [
               "sr:sport:2",
               "sr:sport:4",
               "sr:sport:7",
               "sr:sport:13",
               "sr:sport:24",
               "sr:sport:32",
               "sr:sport:34",
               "sr:sport:131",
               "sr:sport:153",
               "sr:sport:157",
               "sr:sport:195"
             ]
  end

  test "can parse UOF.API.Descriptions.betstop_reasons/0 response" do
    {:ok, desc} = UOF.API.Descriptions.betstop_reasons()

    reason = hd(desc.betstop_reason)

    assert Enum.count(desc.betstop_reason) == 90
    assert reason.id == 0
    assert reason.description == "UNKNOWN"
  end

  test "can parse UOF.API.Descriptions.betting_statuses/0 response" do
    {:ok, desc} = UOF.API.Descriptions.betting_statuses()

    status = hd(desc.betting_status)

    assert Enum.count(desc.betting_status) == 7
    assert status.id == 0
    assert status.description == "UNKNOWN"
  end

  test "can parse UOF.API.Descriptions.void_reasons/0 response" do
    {:ok, desc} = UOF.API.Descriptions.void_reasons()

    reason = hd(desc.void_reason)

    assert Enum.count(desc.void_reason) == 17
    assert reason.id == 0
    assert reason.description == "OTHER"
  end

  test "can parse UOF.API.Descriptions.variants/{0, 1} response" do
    {:ok, desc} = UOF.API.Descriptions.variants()

    assert Enum.count(desc.variant) == 144
    variant = hd(desc.variant)
    assert variant.id == "sr:correct_score:after:4"
    assert Enum.count(variant.outcomes.outcome) == 5
    outcome = hd(variant.outcomes.outcome)
    assert outcome.id == "sr:correct_score:after:4:1530"
    assert outcome.name == "4:0"
    assert Enum.count(variant.mappings.mapping) == 1
    mapping = hd(variant.mappings.mapping)
    assert mapping.product_id == 3
    assert mapping.product_ids == "3"
    assert mapping.sport_id == "sr:sport:22"
    assert mapping.market_id == "1262"
    assert mapping.product_market_id == "960"
    assert Enum.count(mapping.mapping_outcome) == 5
    outcome_mapping = hd(mapping.mapping_outcome)
    assert outcome_mapping.outcome_id == "sr:correct_score:after:4:1530"
    assert outcome_mapping.product_outcome_id == "26"
    assert outcome_mapping.product_outcome_name == "4:0"
  end

  test "can parse UOF.API.Descriptions.producers/0 response" do
    {:ok, desc} = UOF.API.Descriptions.producers()

    producer = hd(desc.producer)

    assert Enum.count(desc.producer) == 15
    assert producer.id == 1
    assert producer.name == "LO"
    assert producer.description == "Live Odds"
    assert producer.api_url == "https://stgapi.betradar.com/v1/liveodds/"
    assert producer.active == true
    assert producer.scope == "live"
    assert producer.stateful_recovery_window_in_minutes == 600
  end
end
