defmodule UOF.API.Descriptions do
  @moduledoc """
  Descriptions API.

  Static, mostly language-dependent metadata that describes the values used
  throughout the feed: market and variant descriptions, producers, sport-specific
  match statuses and betting statuses used in `odds_change` messages, betstop
  reasons, and void reasons used in `bet_settlement` messages.

  Every function returns `{:ok, struct} | {:error, Ecto.Changeset.t()}`, where
  the struct is an `UOF.Schemas.API.Descriptions.*` embedded schema. Endpoints
  that vary by language take an optional `lang` (ISO code, default `"en"`).
  """
  alias UOF.API.Utils.HTTP

  @doc """
  Describe all currently available markets.
  """
  def markets(lang \\ "en") do
    # TO-DO: Optional mappings
    endpoint = ["descriptions", lang, "markets.xml"]

    HTTP.get(endpoint)
  end

  @doc """
  Describe all sport-specific match status codes used during live matches in
  `odds_change` messages.
  """
  def match_statuses(lang \\ "en") do
    endpoint = ["descriptions", lang, "match_status.xml"]

    HTTP.get(endpoint)
  end

  @doc """
  Describe all bet stop reasons.
  """
  def betstop_reasons do
    endpoint = ["descriptions", "betstop_reasons.xml"]

    HTTP.get(endpoint)
  end

  @doc """
  Describes all betting statuses used in `odds_change` messages.
  """
  def betting_statuses do
    endpoint = ["descriptions", "betting_status.xml"]

    HTTP.get(endpoint)
  end

  @doc """
  Get a list of all variants and which markets they are used for.
  """
  def variants(lang \\ "en") do
    endpoint = ["descriptions", lang, "variants.xml"]

    HTTP.get(endpoint)
  end

  @doc """
  Describe all currently available producers and their ids.
  """
  def producers do
    endpoint = ["descriptions", "producers.xml"]

    HTTP.get(endpoint)
  end

  @doc """
  Describe all possible void reasons used in `bet_settlement` messages.
  """
  def void_reasons do
    endpoint = ["descriptions", "void_reasons.xml"]

    HTTP.get(endpoint)
  end
end
