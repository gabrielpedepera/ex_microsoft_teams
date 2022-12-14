defmodule ExMicrosoftTeams.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_microsoft_teams,
      version: "0.1.2",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      docs: docs(),
      deps: deps()
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
      {:tesla, "~> 1.4"},
      {:hackney, "~> 1.17"},
      {:jason, ">= 1.0.0"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:mox, "~> 1.0", only: :test}
    ]
  end

  defp description do
    """
    Elixir library for integration with Microsoft Teams Incoming Webhook.
    """
  end

  defp package do
    # These are the default files included in the package
    [
      name: :ex_microsoft_teams,
      maintainers: ["Gabriel Pereira"],
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/gabrielpedepera/ex_microsoft_teams"}
    ]
  end

  defp docs do
    [
      extras: ["README.md"],
      main: "readme"
    ]
  end
end
