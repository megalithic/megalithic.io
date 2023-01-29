defmodule MegalithicWeb.SEO do
  @moduledoc "Optimize this mug.."

  use Phoenix.Component

  def meta(assigns) do
    assigns =
      assigns
      |> assign_new(:canonical_url, fn ->
        "https://megalithic.io#{Phoenix.Controller.current_path(assigns.conn)}"
      end)
      |> assign_new(:site, fn -> %MegalithicWeb.SEO.Generic{} end)
      |> assign_new(:breadcrumbs, fn -> nil end)
      |> assign_new(:og, fn -> nil end)

    ~H"""
    <meta name="description" content={@site.description}>
    <%= if @canonical_url do %>
      <link rel="canonical" href={@canonical_url}>
      <% end %>
    <meta property="og:url" content={Phoenix.Controller.current_url(assigns.conn)}>
    <meta property="og:image" content={MegalithicWeb.Router.Helpers.static_url(assigns.conn, "/images/megalithic_io.png")}>
    <%= if @og do %>
      <.opengraph og={@og} />
      <% end %>
    <%= if @breadcrumbs do %>
      <script type="application/ld+json">
      <%= Phoenix.HTML.raw(Jason.encode!(@breadcrumbs)) %>
      </script>
      <% end %>
    """
  end

  def opengraph(assigns) do
    ~H"""
    <meta property="og:site_title" content={@og.site_title}>
    <meta property="og:type" content={@og.type}>
    <meta property="og:locale" content={@og.locale}>
    <meta property="og:article:section" content={@og.article_section}>
    <%= if @og.published_at do %>
      <meta property="og:article:published_time" content={@og.published_at}>
      <meta name="twitter:data1" content="Reading Time">
      <meta name="twitter:label1" content={@og.reading_time}>
      <meta name="twitter:data2" content="Published">
      <meta name="twitter:label2" content={@og.published_at}>
    <% end %>
    <meta property="og:title" content={@og.title}>
    <meta property="og:description" content={@og.description}>
    <meta property="twitter:title" content={@og.title}>
    <meta property="twitter:site" content={@og.site}>
    <%= if @og.image_url do %>
      <meta name="twitter:card" content="summary_large_image">
      <meta property="twitter:image:alt" content={@og.image_alt}>
      <meta property="og:image" content={@og.image_url}>
      <meta property="og:image:alt" content={@og.image_alt}>
    <% else %>
      <meta name="twitter:card" content="summary">
    <% end %>
    <%= if @og.twitter_handle do %>
      <meta name="twitter:creator" content={@og.twitter_handle}>
    <% end %>
    """
  end
end
