defmodule UOF.API.Utils.HTTP do
  @moduledoc false

  alias UOF.API.Error

  def get(path, params \\ []) do
    client()
    |> Req.get(url: Enum.join(path, "/"), params: params)
    |> handle_response()
  end

  def post(path, body \\ "", params \\ []) do
    client()
    |> Req.post(url: Enum.join(path, "/"), params: params, body: body)
    |> handle_response()
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

  # Classify the HTTP status before decoding: successful endpoints are polymorphic
  # on their XML root element, while errors may be XML, JSON, HTML, or empty.
  defp handle_response({:ok, %Req.Response{status: status} = response})
       when status in 200..299 do
    decode_success(response)
  end

  defp handle_response({:ok, %Req.Response{} = response}) do
    {:error, http_error(response)}
  end

  defp handle_response({:error, reason}) do
    {:error,
     %Error{
       type: :transport,
       reason: reason,
       message: "UOF API transport error: #{format_reason(reason)}"
     }}
  end

  defp decode_success(%Req.Response{body: body}) when body in [nil, ""], do: {:ok, nil}

  defp decode_success(%Req.Response{body: body} = response) when is_binary(body) do
    if String.trim(body) == "" do
      {:ok, nil}
    else
      decode_xml(response)
    end
  end

  defp decode_success(%Req.Response{} = response) do
    {:error, decode_error(response, {:unexpected_body, response.body})}
  end

  defp decode_xml(%Req.Response{body: body} = response) do
    case UOF.Schemas.XML.decode(body) do
      {:ok, decoded} -> {:ok, decoded}
      {:error, reason} -> {:error, decode_error(response, reason)}
    end
  rescue
    exception -> {:error, decode_error(response, exception)}
  end

  defp http_error(%Req.Response{} = response) do
    body = decode_error_body(response.body)
    response_code = body_value(body, :response_code)
    detail = body_value(body, :message) || body_value(body, :errors)

    %Error{
      type: :http,
      status: response.status,
      response_code: response_code,
      headers: response.headers,
      body: body,
      message: http_error_message(response.status, response_code, detail)
    }
  end

  defp decode_error_body(body) when body in [nil, ""], do: body

  defp decode_error_body(body) when is_binary(body) do
    if String.trim(body) == "" do
      body
    else
      case UOF.Schemas.XML.decode(body) do
        {:ok, decoded} -> decoded
        {:error, _reason} -> body
      end
    end
  rescue
    _exception -> body
  end

  defp decode_error_body(body), do: body

  defp decode_error(%Req.Response{} = response, reason) do
    %Error{
      type: :decode,
      status: response.status,
      headers: response.headers,
      body: response.body,
      reason: reason,
      message: "Unable to decode UOF API response: #{format_reason(reason)}"
    }
  end

  defp body_value(body, key) when is_map(body) do
    Map.get(body, key) || Map.get(body, Atom.to_string(key))
  end

  defp body_value(_body, _key), do: nil

  defp http_error_message(status, response_code, detail) do
    suffix = detail || response_code

    if suffix do
      "UOF API returned HTTP #{status}: #{format_detail(suffix)}"
    else
      "UOF API returned HTTP #{status}"
    end
  end

  defp format_detail(detail) when is_binary(detail), do: detail
  defp format_detail(detail), do: inspect(detail)

  defp format_reason(%{__exception__: true} = exception), do: Exception.message(exception)
  defp format_reason(reason), do: inspect(reason)
end
