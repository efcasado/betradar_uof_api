defmodule UofApi.MixProject do
  use Mix.Project

  def project do
    [
      app: :uof_api,
      version: "3.0.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
      description: description(),
      package: package(),
      docs: docs(),
      deps: deps(),
      name: "UOF_API",
      source_url: "https://github.com/efcasado/uof_api"
    ]
  end

  def cli do
    [
      preferred_envs: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test,
        "coveralls.github": :test
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:uof_schemas, "~> 0.3"},
      {:req, "~> 0.6.2"},
      {:xml_builder, "~> 2.3"},
      # dev
      {:ex_doc, "~> 0.31", only: :dev, runtime: false},
      {:styler, "~> 1.11", only: [:dev, :test], runtime: false},
      {:mimic, "~> 2.3", only: :test},
      {:excoveralls, "~> 0.18", only: :test},
      {:junit_formatter, "~> 3.3", only: :test}
    ]
  end

  defp description do
    "An Elixir client for Betradar's Unified Odds Feed (UOF) API"
  end

  defp package do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/efcasado/uof_api"}
    ]
  end

  defp docs do
    [
      main: "readme",
      extras: ["README.md"]
    ]
  end
end
