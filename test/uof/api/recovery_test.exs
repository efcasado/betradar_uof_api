defmodule UOF.API.Recovery.Test do
  use ExUnit.Case
  use Mimic

  setup do
    stub(UOF.API.Utils.HTTP, :post, fn _endpoint, _body, _params ->
      data = File.read!("test/data/recovery_response.xml")
      UOF.Schemas.XML.decode(data)
    end)

    :ok
  end

  test "recover/2 initiates a full odds recovery" do
    {:ok, response} =
      UOF.API.Recovery.recover("liveodds", request_id: 42, after: 1_700_000_000_000)

    assert response.response_code == "ACCEPTED"
    assert response.action == "Recovery request accepted"
    assert response.message == "request_id=42"
  end

  test "recover_event/3 recovers odds for a single sport event" do
    {:ok, response} = UOF.API.Recovery.recover_event("liveodds", "sr:match:12345", request_id: 42)

    assert response.response_code == "ACCEPTED"
  end

  test "recover_stateful_messages/3 recovers stateful messages for a sport event" do
    {:ok, response} =
      UOF.API.Recovery.recover_stateful_messages("liveodds", "sr:match:12345", request_id: 42)

    assert response.response_code == "ACCEPTED"
  end
end
