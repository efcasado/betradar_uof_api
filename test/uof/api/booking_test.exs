defmodule UOF.API.Booking.Test do
  use ExUnit.Case
  use Mimic

  setup do
    stub(UOF.API.Utils.HTTP, :post, fn _endpoint ->
      data = File.read!("test/data/booking_response.xml")
      UOF.Schemas.XML.decode(data)
    end)

    :ok
  end

  test "book/1 books a sport event for live odds" do
    {:ok, response} = UOF.API.Booking.book("sr:match:12345")

    assert response.response_code == "OK"
    assert response.action == "Event booked"
  end
end
