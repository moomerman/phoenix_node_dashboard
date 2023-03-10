defmodule Phoenix.NodeDashboard.Component do
  use Phoenix.LiveComponent
  use Phoenix.HTML
  require Logger
  alias Phoenix.NodeDashboard.Instance

  @impl true
  def mount(socket) do
    nodes =
      Enum.map([Node.self()] ++ Node.list(), fn node ->
        %{node: node, name: node, status: "loading"}
      end)

    {:ok, assign(socket, :nodes, nodes)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div style="display: flex; flex-direction: column;">
      <.title text="Nodes" />
      <.node_grid nodes={@nodes} />
    </div>
    """
  end

  @impl true
  def update(%{selected_node: selected_node}, socket) do
    socket =
      if connected?(socket) do
        assign(socket, :nodes, fetch_nodes())
      else
        socket
      end

    {:ok, assign(socket, selected_node: selected_node)}
  end

  defp title(assigns) do
    ~H"""
    <h5 style="font-size: 1.25rem; margin-bottom: 0.75rem;">
      <%= @text %>
    </h5>
    """
  end

  defp node_grid(assigns) do
    ~H"""
    <div style="display: grid; gap: 1rem; grid-template-columns: repeat(3, minmax(0, 1fr));">
      <%= for node <- @nodes do %>
        <.node_card node={node} />
      <% end %>
    </div>
    """
  end

  defp node_card(assigns) do
    ~H"""
    <div style="display: flex; flex-direction: row; background-color: white; border-radius: 0.25rem; padding: 1rem;">
      <.node_detail node={@node} />
    </div>
    """
  end

  defp node_detail(%{node: %{status: "loaded"}} = assigns) do
    ~H"""
    <%= @node.node %>
    <%= @node.uptime %>
    <%= if @node.node == Node.self() do %>
      <span class="">*Current*</span>
    <% end %>
    """
  end

  defp node_detail(%{node: %{status: "loading"}} = assigns) do
    ~H"""
    <div style="display: flex; flex-direction: row; align-items: center; gap: 0.5rem">
      <svg
        style="width: 1rem; height: 1rem"
        xmlns="http://www.w3.org/2000/svg"
        fill="none"
        viewBox="0 0 24 24"
      >
        <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4">
        </circle>
        <path
          class="opacity-75"
          fill="currentColor"
          d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"
        >
        </path>
      </svg>
      <%= @node.name %>
    </div>
    """
  end

  defp fetch_nodes() do
    ([Node.self()] ++ Node.list())
    |> Enum.map(fn node ->
      Logger.debug("#{__MODULE__}#update/2 checking node #{node}")
      Instance.rpc(node)
    end)
  end
end
