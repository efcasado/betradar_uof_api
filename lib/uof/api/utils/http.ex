defmodule UOF.API.Utils.HTTP do
  @moduledoc false

  def get(path, params \\ []) do
    client()
    |> Req.get!(url: Enum.join(path, "/"), params: params)
    |> decode()
  end

  def post(path, body \\ "", params \\ []) do
    client()
    |> Req.post!(url: Enum.join(path, "/"), params: params, body: body)
    |> decode()
  end

  defp client do
    Req.new(
      base_url: Application.fetch_env!(:uof_api, :base_url) <> "/",
      headers: %{
        "x-access-token" => Application.fetch_env!(:uof_api, :auth_token),
        "content-type" => "application/xml",
        "accept" => "application/xml"
      }
    )
  end

  # Every endpoint is polymorphic on its XML root element (a season request to the
  # fixture endpoint returns <tournament_info>, any endpoint may return the shared
  # <response> error envelope), so dispatch on the root via decode/1 rather than
  # asserting a fixed schema.
  defp decode(%Req.Response{body: body}), do: UOF.Schemas.XML.decode(body)
end
