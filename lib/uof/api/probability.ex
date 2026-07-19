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
  Get probabilities for the given fixture.
  """
  def probabilities(fixture) do
    endpoint = ["probabilities", fixture]
    HTTP.get(endpoint)
  end

  @doc """
  Get probabilities for the specified market in the given fixture.
  """
  def probabilities(fixture, market) do
    endpoint = ["probabilities", fixture, market]
    HTTP.get(endpoint)
  end

  @doc """
  Get probabilities for the specified market with specifier in the given fixture.
  """
  def probabilities(fixture, market, specifier) do
    endpoint = ["probabilities", fixture, market, specifier]
    HTTP.get(endpoint)
  end
end
