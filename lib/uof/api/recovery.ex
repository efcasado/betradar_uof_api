defmodule UOF.API.Recovery do
  @moduledoc """
  Odds Recovery API.

  Recovery requests are issued per `product` — the producer's path segment, such
  as `"liveodds"`, `"pre"` or `"ctrl"` (see `UOF.API.Descriptions.producers/0`).
  The HTTP response is only an acknowledgement and may have no body (`nil`) or
  contain an `UOF.Schemas.Common.Response`; the recovered messages themselves
  are delivered over the AMQP feed and the sequence ends with a
  `snapshot_complete` message correlated by `request_id`.

  Functions return `{:ok, response_or_nil} | {:error, UOF.API.Error.t()}`.

  Common options:

    * `:request_id` — correlates the resulting `snapshot_complete` feed message
    * `:node_id` — target a specific feed node
    * `:after` — only on `recover/2`; milliseconds since the Unix epoch (UTC)
  """
  alias UOF.API.Utils.HTTP

  @doc """
  Initiate a full odds recovery for the given `product`.

  With `:after`, recovers messages generated after that timestamp; without it,
  recovers a full snapshot of the current odds.
  """
  def recover(product, opts \\ []) do
    endpoint = [product, "recovery", "initiate_request"]
    HTTP.post(endpoint, "", Keyword.take(opts, [:after, :request_id, :node_id]))
  end

  @doc """
  Recover odds for a single `sport_event` (e.g. `"sr:match:12345"`).
  """
  def recover_event(product, sport_event, opts \\ []) do
    endpoint = [product, "odds", "events", sport_event, "initiate_request"]
    HTTP.post(endpoint, "", Keyword.take(opts, [:request_id, :node_id]))
  end

  @doc """
  Recover stateful messages (e.g. `bet_settlement`, `bet_cancel`) for a single
  `sport_event`.
  """
  def recover_stateful_messages(product, sport_event, opts \\ []) do
    endpoint = [product, "stateful_messages", "events", sport_event, "initiate_request"]
    HTTP.post(endpoint, "", Keyword.take(opts, [:request_id, :node_id]))
  end
end
