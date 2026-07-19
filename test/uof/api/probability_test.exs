defmodule UOF.API.Probability.Test do
  use ExUnit.Case
  use Mimic

  alias UOF.API.Probability
  alias UOF.API.Utils.HTTP
  alias UOF.Schemas.XML

  setup do
    stub(HTTP, :get, fn _endpoint, _params, _opts ->
      data = File.read!("test/data/cashout.xml")
      XML.decode(data)
    end)

    :ok
  end

  test "can parse UOF.API.Probability.probabilities/1" do
    {:ok, cashout} = Probability.probabilities("sr:match:41878167")

    assert cashout.sport_event_status.status == 1
    assert cashout.sport_event_status.match_status == 7
    assert Enum.count(cashout.odds.market) == 162
    [market1, market2 | _] = cashout.odds.market
    assert market1.status == -3
    assert market1.cashout_status == -2
    assert market1.id == 66
    assert market1.specifiers == "hcp=0.5"
    assert market1.outcome == []
    assert market2.status == 1
    assert market2.cashout_status == 1
    assert market2.id == 547
    assert market2.specifiers == "total=4.5"
    assert Enum.count(market2.outcome) == 6
    outcome = hd(market2.outcome)
    assert outcome.id == "1729"
    assert outcome.active == 1
    assert_in_delta outcome.probabilities, 3.58e-4, 0.01e-4
  end

  test "probabilities/2 requests the market-scoped endpoint" do
    stub(HTTP, :get, fn endpoint, _params, _opts ->
      assert endpoint == ["probabilities", "sr:match:41878167", "66"]
      XML.decode(File.read!("test/data/cashout.xml"))
    end)

    assert {:ok, _cashout} = Probability.probabilities("sr:match:41878167", "66")
  end

  test "probabilities/3 requests the market+specifier-scoped endpoint" do
    stub(HTTP, :get, fn endpoint, _params, _opts ->
      assert endpoint == ["probabilities", "sr:match:41878167", "66", "hcp=0.5"]
      XML.decode(File.read!("test/data/cashout.xml"))
    end)

    assert {:ok, _cashout} =
             Probability.probabilities("sr:match:41878167", "66", "hcp=0.5")
  end
end
