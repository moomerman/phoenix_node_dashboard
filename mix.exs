defmodule Phoenix.NodeDashboard.MixProject do
  use Mix.Project

  @source_url "https://github.com/moomerman/phoenix_node_dashboard"
  @version "0.1.0"

  def project do
    [
      app: :phoenix_node_dashboard,
      version: @version,
      elixir: "~> 1.14",
      description: "A Phoenix LiveDashboard Page to visualise connected Nodes",
      source_url: @source_url,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      docs: docs()
    ]
  end

  defp package() do
    [
      files: ~w(lib mix.exs README* LICENSE*),
      links: %{GitHub: @source_url},
      licenses: ["MIT"]
    ]
  end

  defp docs() do
    [
      extras: [
        "README.md": [title: "Overview"],
        LICENSE: [title: "License"]
      ],
      main: "readme"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:jason, "~> 1.0"},
      {:phoenix_live_dashboard, "~> 0.7.2"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end
end
