defmodule MegalithicWeb.Components.Header do
  use MegalithicWeb, :live_component

  alias MegalithicWeb.Components.SVG
  alias MegalithicWeb.Router.Helpers, as: Routes

  @impl true
  def render(assigns) do
    ~H"""
    <header class="header">
      <SVG.megalith />
      <nav class="primary">
        <h1>
          <%= live_patch("megalithic industries", to: Routes.blog_path(@socket, :index)) %>
        </h1>
        <ul>
          <li>
            <%= live_patch("blog", to: Routes.blog_path(@socket, :index)) %>
          </li>
          <li>
            <%= live_patch("about", to: Routes.page_path(@socket, :about)) %>
          </li>
        </ul>
      </nav>
      <nav class="secondary">
        <ul>
          <li>
            <button id="theme-toggle" type="button" class="theme-toggle-button">
              <SVG.theme_toggle />
            </button>
          </li>
          <li>
            <%= outbound_link to: "https://twitter.com/megalithic", title: "Twitter" do %>
              <span class="sr-only">
                Twitter
              </span>
              <SVG.twitter_small />
            <% end %>
          </li>
          <li>
            <%= outbound_link to: "https://github.com/megalithic", title: "GitHub" do %>
              <span class="sr-only">
                GitHub
              </span>
              <SVG.github_small />
            <% end %>
          </li>
          <li>
            <%= link to: Routes.robot_path(@socket, :rss), title: "RSS Feed" do %>
              <span class="sr-only">
                RSS Feed
              </span>
              <SVG.rss_small />
            <% end %>
          </li>
          <li>
            <%= outbound_link to: "https://plausible.io/megalithic.io", title: "Plausible" do %>
              <span class="sr-only">
                Analytics
              </span>
              <SVG.plausible_small />
            <% end %>
          </li>
        </ul>
      </nav>
    </header>
    """
  end
end
