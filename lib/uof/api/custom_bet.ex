defmodule UOF.API.CustomBet do
  @moduledoc """
  CustomBet is an extension for Unified Odds Feed and allows the creation of
  custom tailored bets for a specific fixture. In CustomBet it is possible to
  combine a wide range of betting markets into one single odds and probabilities
  calculation as if it was a regular accumulator bet.

  CustomBet API is only available for soccer and basketball fixtures.

  Functions return `{:ok, response} | {:error, UOF.API.Error.t()}`.
  """
  alias UOF.API.Utils.HTTP

  @doc """
  Get the markets that are available to be used in a custom bet from the given
  fixture.
  """
  def available_selections(fixture, opts \\ []) do
    endpoint = ["custombet", fixture, "available_selections"]

    HTTP.get(endpoint, [], opts)
  end

  @doc """
  Calculate the probability and odds for the given selections. It also returns
  a list of further markets that can be added to the custom bet.
  """
  def calculate(selections, filter \\ false, opts \\ []) do
    body = selections_to_xml(selections, filter)
    endpoint = calculate_endpoint(filter)
    HTTP.post(endpoint, body, [], opts)
  end

  defp calculate_endpoint(true), do: ["custombet", "calculate-filter"]
  defp calculate_endpoint(false), do: ["custombet", "calculate"]

  defp selections_to_xml(selections, false) do
    selections
    |> Enum.map(fn
      {id, mid, oid} ->
        {:selection, %{id: id, market_id: mid, outcome_id: oid}, []}

      {id, mid, oid, s} ->
        {:selection, %{id: id, market_id: mid, outcome_id: oid, specifiers: s}, []}
    end)
    |> then(fn selections ->
      {:selections,
       %{
         xmlns: "http://schemas.sportradar.com/custombet/v1/endpoints",
         "xmlns:xsi": "http://www.w3.org/2001/XMLSchema-instance",
         "xsi:schemaLocation":
           "http://schemas.sportradar.com/custombet/v1/endpoints http://schemas.sportradar.com/custombet/v1/endpoints/Selections.xsd"
       }, selections}
    end)
    |> XmlBuilder.generate()
  end

  defp selections_to_xml(selections, true) do
    [selection | _] = selections
    id = elem(selection, 0)

    selections
    |> Enum.map(fn
      {_id, mid, oid} ->
        {:market, %{market_id: mid, outcome_id: oid}, []}

      {_id, mid, oid, s} ->
        {:market, %{market_id: mid, outcome_id: oid, specifiers: s}, []}
    end)
    |> then(fn selections ->
      {:filterSelections, %{xmlns: "http://schemas.sportradar.com/custombet/v1/endpoints"},
       [{:selection, %{id: id}, selections}]}
    end)
    |> XmlBuilder.generate()
  end
end
