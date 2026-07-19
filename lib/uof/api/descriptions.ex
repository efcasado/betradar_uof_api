defmodule UOF.API.Descriptions do
  @moduledoc """
  Descriptions API.

  Static, mostly language-dependent metadata that describes the values used
  throughout the feed: market and variant descriptions, producers, sport-specific
  match statuses and betting statuses used in `odds_change` messages, betstop
  reasons, and void reasons used in `bet_settlement` messages.

  Every function returns `{:ok, struct} | {:error, UOF.API.Error.t()}`, where
  the struct is an `UOF.Schemas.API.Descriptions.*` embedded schema. Endpoints
  that vary by language take an optional `lang` (ISO code, default `"en"`).
  All functions accept a trailing `opts` keyword list merged into the Req
  request (see `UOF.API.Utils.HTTP`).
  """
  alias UOF.API.Utils.HTTP

  @doc """
  Describe all currently available markets.

  Pass `include_mappings: true` to also include each market's mappings to
  provider-specific market/outcome ids.
  """
  def markets(lang \\ "en", include_mappings \\ false, opts \\ []) do
    endpoint = ["descriptions", lang, "markets.xml"]

    HTTP.get(endpoint, [include_mappings: include_mappings], opts)
  end

  @doc """
  Describe all sport-specific match status codes used during live matches in
  `odds_change` messages.
  """
  def match_statuses(lang \\ "en", opts \\ []) do
    endpoint = ["descriptions", lang, "match_status.xml"]

    HTTP.get(endpoint, [], opts)
  end

  @doc """
  Describe all bet stop reasons.
  """
  def betstop_reasons(opts \\ []) do
    endpoint = ["descriptions", "betstop_reasons.xml"]

    HTTP.get(endpoint, [], opts)
  end

  @doc """
  Describes all betting statuses used in `odds_change` messages.
  """
  def betting_statuses(opts \\ []) do
    endpoint = ["descriptions", "betting_status.xml"]

    HTTP.get(endpoint, [], opts)
  end

  @doc """
  Get a list of all variants and which markets they are used for.
  """
  def variants(lang \\ "en", opts \\ []) do
    endpoint = ["descriptions", lang, "variants.xml"]

    HTTP.get(endpoint, [], opts)
  end

  @doc """
  Describe all currently available producers and their ids.
  """
  def producers(opts \\ []) do
    endpoint = ["descriptions", "producers.xml"]

    HTTP.get(endpoint, [], opts)
  end

  @doc """
  Describe all possible void reasons used in `bet_settlement` messages.
  """
  def void_reasons(opts \\ []) do
    endpoint = ["descriptions", "void_reasons.xml"]

    HTTP.get(endpoint, [], opts)
  end
end
