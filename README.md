# Phoenix.NodeDashboard

This library adds a new Page to Pheonix LiveDashboard to visualise connected Nodes.

TODO: Add Screenshot!

## Installation

The package can be installed by adding `phoenix_node_dashboard` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:phoenix_node_dashboard, "~> 0.1.0"}
  ]
end
```

The docs can be found at <https://hexdocs.pm/phoenix_node_dashboard>.

## Config

Configure `phoenix_node_dashboard` in your router by adding an additional page like this:

```elixir
live_dashboard "/dashboard",
    metrics: HelloWeb.Telemetry,
    additional_pages: [phoenix_node_dashboard: Phoenix.NodeDashboard.Page]
```
