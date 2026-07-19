defmodule UOF.API.Probability do
  @moduledoc """
  Betradar's Probability API can be used to fetch the probabilities for all
  active markets offered by Betradar's Unified Odds Feed product.

  Probabilities can go down to `1e-10` (ie. `0.0000000001`).

  The only supported sports are: soccer, baseball, basketball, tennis, table
  tennis, badminton, volleyball, squash, handball, ice hockey and field hockey.

  For a fixture to be available in the Probability API, the fixture must be
  active in `Live Odds` and you must have `Live Odds` access to this fixture.

  Functions return `{:ok, response} | {:error, UOF.API.Error.t()}`.
  """
  alias UOF.API.Utils.HTTP

  @doc """
  Get probabilities for the given fixture, optionally narrowed to a `market`
  and, within it, a `specifier`.

  The trailing `opts` is a keyword list merged into the Req request (see
  `UOF.API.Utils.HTTP`); to pass it while leaving `market`/`specifier`
  unset, call `probabilities(fixture, nil, nil, opts)`.
  """
  def probabilities(fixture, market \\ nil, specifier \\ nil, opts \\ []) do
    endpoint = ["probabilities", fixture] ++ Enum.reject([market, specifier], &is_nil/1)
    HTTP.get(endpoint, [], opts)
  end
end
