defmodule UOF.API.Utils.HTTP.Test do
  use ExUnit.Case
  use Mimic

  alias UOF.API.Error
  alias UOF.API.Utils.HTTP

  setup do
    Application.put_env(:uof_api, :base_url, "https://example.test/v1")
    Application.put_env(:uof_api, :auth_token, "token")

    on_exit(fn ->
      Application.delete_env(:uof_api, :base_url)
      Application.delete_env(:uof_api, :auth_token)
    end)

    :ok
  end

  test "decodes a successful XML response" do
    expect(Req, :get, fn _request, _options ->
      {:ok,
       Req.Response.new(
         status: 200,
         body: ~s(<response response_code="OK"><message>Ready</message></response>)
       )}
    end)

    assert {:ok, response} = HTTP.get(["status.xml"])
    assert response.response_code == "OK"
    assert response.message == "Ready"
  end

  test "accepts an empty response for any successful HTTP status" do
    expect(Req, :post, fn _request, _options ->
      {:ok, Req.Response.new(status: 202, body: "")}
    end)

    assert {:ok, nil} = HTTP.post(["liveodds", "recovery", "initiate_request"])
  end

  test "returns a structured error for an XML HTTP error" do
    expect(Req, :get, fn _request, _options ->
      {:ok,
       Req.Response.new(
         status: 404,
         body:
           ~s(<response response_code="NOT_FOUND"><message>No data for event</message></response>)
       )}
    end)

    assert {:error, %Error{} = error} = HTTP.get(["missing.xml"])
    assert error.type == :http
    assert error.status == 404
    assert error.response_code == "NOT_FOUND"
    assert error.message == "UOF API returned HTTP 404: No data for event"
    assert error.body.message == "No data for event"
  end

  test "preserves decoded JSON error bodies and response headers" do
    expect(Req, :get, fn _request, _options ->
      {:ok,
       Req.Response.new(
         status: 429,
         headers: [{"retry-after", "5"}],
         body: %{"message" => "Rate limit reached"}
       )}
    end)

    assert {:error, %Error{} = error} = HTTP.get(["probabilities", "sr:match:1"])
    assert error.status == 429
    assert error.headers["retry-after"] == ["5"]
    assert error.body == %{"message" => "Rate limit reached"}
    assert error.message == "UOF API returned HTTP 429: Rate limit reached"
  end

  test "preserves non-XML error bodies" do
    html = "<html><h1>503 Service Unavailable</h1></html>"

    expect(Req, :get, fn _request, _options ->
      {:ok, Req.Response.new(status: 503, body: html)}
    end)

    assert {:error, %Error{} = error} = HTTP.get(["sports.xml"])
    assert error.status == 503
    assert error.body == html
    assert error.message == "UOF API returned HTTP 503"
  end

  test "returns transport failures instead of raising" do
    expect(Req, :get, fn _request, _options ->
      {:error, %RuntimeError{message: "connection closed"}}
    end)

    assert {:error, %Error{} = error} = HTTP.get(["sports.xml"])
    assert error.type == :transport
    assert error.status == nil
    assert error.message == "UOF API transport error: connection closed"
  end

  test "returns decoding failures instead of raising" do
    expect(Req, :get, fn _request, _options ->
      {:ok, Req.Response.new(status: 200, body: "not XML")}
    end)

    assert {:error, %Error{} = error} = HTTP.get(["sports.xml"])
    assert error.type == :decode
    assert error.status == 200
    assert error.body == "not XML"
    assert error.reason
  end
end
