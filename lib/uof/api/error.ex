defmodule UOF.API.Error do
  @moduledoc """
  An error returned by the UOF HTTP client.

  `type` distinguishes errors returned by the API from transport and response
  decoding failures. For HTTP errors, `status` is the numeric HTTP status and
  `response_code` is the separate code supplied by Sportradar in the response
  body, when present.

  The remaining fields contain:

    * `headers` — response headers, including values such as `retry-after`
    * `body` — a decoded XML/JSON body when possible, otherwise the raw body
    * `reason` — the underlying transport or decoding failure
    * `message` — a human-readable error summary
  """

  @type error_type :: :http | :transport | :decode

  @type t :: %__MODULE__{
          type: error_type(),
          status: non_neg_integer() | nil,
          response_code: String.t() | nil,
          headers: map(),
          body: term(),
          reason: term(),
          message: String.t()
        }

  defexception type: nil,
               status: nil,
               response_code: nil,
               headers: %{},
               body: nil,
               reason: nil,
               message: "UOF API request failed"
end
