defmodule Phoenix.NodeDashboard.Page do
  @moduledoc false
  use Phoenix.LiveDashboard.PageBuilder

  @impl true
  def menu_link(_, _) do
    {:ok, "Nodes"}
  end

  @impl true
  def render_page(%{page: %{node: node}}) do
    {Phoenix.NodeDashboard.Component,
     %{id: :phoenix_node_dashboard_component, selected_node: node}}
  end
end
