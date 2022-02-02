defmodule MegalithicWeb.Components.Link do
  @moduledoc """
  Phoenix component to handle creating various types of links.

  The passed-in `assigns` map accepts:
  ```
  %{
    label: String.t(),
    class: String.t(),
    as: ["a", "live_patch", "live_redirect"],
  }
  ```
  """

  use Phoenix.Component

  def link(assigns) do
    extra_attributes =
      assigns_to_attributes(assigns, [
        :class,
        :as,
        :to,
        :label,
        :active
      ])
      |> List.insert_at(0, {:role, "link"})

    assigns =
      assigns
      |> assign_new(:class, fn -> default_class() end)
      |> assign_new(:as, fn -> "a" end)
      |> assign_new(:label, fn -> nil end)
      |> assign_new(:active, fn -> false end)
      |> assign_new(:inner_block, fn -> nil end)
      |> assign(:extra_attributes, extra_attributes)

    ~H"""
    <%= case @as do %>
    <% "a" -> %>
      <%= Phoenix.HTML.Link.link [to: @to, class: class_list([default_class(), active_class(@active), @class])] ++ @extra_attributes do %>
        <%= if @inner_block do %>
          <%= render_slot(@inner_block) %>
        <% else %>
          <%= @label %>
        <% end %>
      <% end %>
    <% "live_patch" -> %>
      <%= live_patch [
          to: @to,
          class: class_list([default_class(), active_class(@active), @class])
          ] ++ @extra_attributes do %>
        <%= if @inner_block do %>
          <%= render_slot(@inner_block) %>
        <% else %>
          <%= @label %>
        <% end %>
      <% end %>
    <% "live_redirect" -> %>
      <%= live_redirect [
          to: @to,
          class: class_list([default_class(), active_class(@active), @class])
          ] ++ @extra_attributes do %>
        <%= if @inner_block do %>
          <%= render_slot(@inner_block) %>
        <% else %>
          <%= @label %>
        <% end %>
      <% end %>
    <% end %>
    """
  end

  defp default_class(), do: "link"
  defp active_class(true), do: "active"
  defp active_class(false), do: ""

  defp class_list(classes) do
    classes
    |> Enum.uniq()
    |> Enum.join(" ")
    |> String.trim()
  end
end
