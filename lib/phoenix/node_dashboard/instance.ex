defmodule Phoenix.NodeDashboard.Instance do
  def current() do
    node_info()
  end

  def rpc(node) do
    {time, response} =
      :timer.tc(fn ->
        :rpc.call(node, __MODULE__, :node_info, [])
      end)

    Map.put(response, :time, div(time, 1_000))
  end

  def node_info do
    %{
      status: "loaded",
      node: Node.self(),
      time: nil,
      uptime: :erlang.statistics(:wall_clock) |> elem(0)
    }
  end

  def region_name(code) do
    case code do
      "ams" -> "Amsterdam, Netherlands"
      "atl" -> "Atlanta, Georgia (US)"
      "cdg" -> "Paris, France"
      "dfw" -> "Dallas, Texas (US)"
      "ewr" -> "Parsippany, NJ (US)"
      "fra" -> "Frankfurt, Germany"
      "gru" -> "Sao Paulo, Brazil"
      "hkg" -> "Hong Kong"
      "iad" -> "Ashburn, Virginia (US)"
      "lax" -> "Los Angeles, California (US)"
      "lhr" -> "London, United Kingdom"
      "maa" -> "Chennai (Madras), India"
      "nrt" -> "Tokyo, Japan"
      "ord" -> "Chicago, Illinois (US)"
      "scl" -> "Santiago, Chile"
      "sea" -> "Seattle, Washington (US)"
      "sin" -> "Singapore"
      "sjc" -> "Sunnyvale, California (US)"
      "syd" -> "Sydney, Australia"
      "yyz" -> "Toronto, Canada"
      _ -> "Unknown"
    end
  end
end
