defmodule MegalithicWeb.SEO.OpenGraph do
  @moduledoc """
  Build OpenGraph tags. This is destined for Facebook, Twitter, and Slack.

  https://developers.facebook.com/docs/sharing/webmasters/
  https://developer.twitter.com/en/docs/tweets/optimize-with-cards/overview/markup
  https://developer.twitter.com/en/docs/tweets/optimize-with-cards/overview/abouts-cards
  https://api.slack.com/reference/messaging/link-unfurling#classic_unfurl

  MOAR to research:
  <%
    og_meta = extract_open_graph(@og_resource, @conn)
  %>
  <title><%= og_meta.title %></title>
  <meta property="og:title" content={ og_meta.title }>
  <meta property="og:description" content={ og_meta.description }>
  <meta property="og:image" content={ og_meta.image }>
  <meta property="og:url" content={ current_url(@conn) }>
  <meta name="twitter:card" content={ og_meta.twitter }>
  <meta property="og:site_name" content={ og_meta.site_name }>
  <meta name="twitter:image:alt" content={ og_meta.image_alt }>

  <meta name="description" content={ og_meta.description }>

  ## TODO
    - Tokenizer that turns HTML into sentences. re: https://github.com/wardbradt/HTMLST
    - Blog post header images
  """

  alias MegalithicWeb.SEO.Generic
  alias MegalithicWeb.Router.Helpers, as: Routes
  @generic %Generic{}
  @endpoint MegalithicWeb.Endpoint

  defstruct [
    :description,
    :expires_at,
    :image_alt,
    :image_url,
    :published_at,
    :reading_time,
    :title,
    article_section: "Software Development",
    locale: "en_US",
    site: "@megalithic",
    site_title: @generic.title,
    twitter_handle: "@megalithic",
    type: "website"
  ]

  def build(%Megalithic.Blog.Post{} = post) do
    %__MODULE__{
      title: truncate(post.title, 70),
      type: "article",
      published_at: format_date(post.date),
      reading_time: format_time(post.reading_time),
      description: String.trim(truncate(post.description, 200))
    }
    |> put_image(post)
  end

  defp put_image(og, post) do
    file = "/images/blog/#{post.id}.png"

    exists? =
      [Application.app_dir(:megalithic), "/priv/static", file]
      |> Path.join()
      |> File.exists?()

    if exists? do
      %{og | image_url: Routes.static_url(@endpoint, file), image_alt: post.title}
    else
      og
    end
  end

  defp truncate(string, length) do
    if String.length(string) <= length do
      string
    else
      String.slice(string, 0..length)
    end
  end

  defp format_date(date), do: Date.to_iso8601(date)

  defp format_time(length), do: "#{length} minutes"
end
