defmodule UOF.API.Users.Test do
  use ExUnit.Case
  use Mimic

  setup do
    stub(UOF.API.Utils.HTTP, :get, fn endpoint, _params, _opts ->
      data = File.read!("test/data/" <> Enum.at(endpoint, -1))
      UOF.Schemas.XML.decode(data)
    end)

    :ok
  end

  test "can parse UOF.API.Users.whoami/0 response" do
    {:ok, details} = UOF.API.Users.whoami()

    assert details.expire_at == ~U[2023-02-03 22:50:17Z]
    assert details.bookmaker_id == 11111
    assert details.virtual_host == "/unifiedfeed/11111"
  end
end
