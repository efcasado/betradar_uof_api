defmodule UOF.API.CustomBet.Test do
  use ExUnit.Case
  use Mimic

  alias UOF.API.CustomBet
  alias UOF.API.Utils.HTTP
  alias UOF.Schemas.XML

  setup do
    stub(HTTP, :get, fn _endpoint, _params, _opts ->
      data = File.read!("test/data/available_selections.xml")
      XML.decode(data)
    end)

    stub(HTTP, :post, fn _endpoint, _body, _params, _opts ->
      data = File.read!("test/data/custombet_calculation.xml")
      XML.decode(data)
    end)

    :ok
  end

  test "can parse UOF.API.CustomBet.available_selections/1 response" do
    {:ok, available_selections} = CustomBet.available_selections("sr:match:42430779")

    assert available_selections.generated_at == ~U[2024-04-28 17:36:46Z]
    assert available_selections.event.id == "sr:match:42430779"

    markets = available_selections.event.markets.market
    assert Enum.count(markets) == 76
    market = Enum.at(markets, 1)
    assert market.id == 87
    assert market.specifiers == "hcp=0:2"
    assert Enum.map(market.outcome, & &1.id) == ["1711", "1712", "1713"]
  end

  test "can parse UOF.API.CustomBet.calculate/1 response" do
    selections = [{"sr:match:42795059", 97, 74}, {"sr:match:42795059", 10, 9}]
    {:ok, calculation} = CustomBet.calculate(selections)

    assert_in_delta Decimal.to_float(calculation.calculation.odds), 5.22, 0.01
    assert_in_delta Decimal.to_float(calculation.calculation.probability), 0.15, 0.01

    event = hd(calculation.available_selections.event)
    markets = event.markets.market
    assert Enum.count(markets) == 76
    market = hd(markets)
    assert market.id == 87
    assert market.specifiers == "hcp=0:2"
    assert Enum.map(market.outcome, & &1.id) == ["1711", "1712", "1713"]
  end

  test "calculate/2 with filter uses the calculate-filter endpoint" do
    stub(HTTP, :post, fn endpoint, body, _params, _opts ->
      assert endpoint == ["custombet", "calculate-filter"]
      assert body =~ ~s(<selection id="sr:match:42795059">)
      assert body =~ ~s(<market market_id="97" outcome_id="74"/>)
      assert body =~ ~s(<market market_id="10" outcome_id="9"/>)
      data = File.read!("test/data/custombet_calculation.xml")
      XML.decode(data)
    end)

    selections = [{"sr:match:42795059", 97, 74}, {"sr:match:42795059", 10, 9}]
    assert {:ok, _calculation} = CustomBet.calculate(selections, true)
  end
end
