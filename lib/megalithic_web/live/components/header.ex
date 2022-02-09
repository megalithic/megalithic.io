defmodule MegalithicWeb.Components.Header do
  use MegalithicWeb, :live_component

  alias MegalithicWeb.Components.SVG
  alias MegalithicWeb.Router.Helpers, as: Routes
  alias Phoenix.LiveView.JS

  def expand_mobile_menu do
    JS.toggle(to: "#mobile_menu_content")
    |> JS.toggle(to: "#mobile_menu_open")
    |> JS.toggle(to: "#mobile_menu_close")
  end

  @impl true
  def render(assigns) do
    ~H"""
    <header class="header">
      <div class="container">
        <SVG.megalith />
        <nav class="primary">
          <h1>
            <%= live_patch("megalithic industries", to: Routes.blog_path(@socket, :index), class: "") %>
          </h1>
          <ul class="hidden sm:flex">
            <li>
              <%= live_patch("blog", to: Routes.blog_path(@socket, :index)) %>
            </li>
            <li>
              <%= live_patch("about", to: Routes.page_path(@socket, :about)) %>
            </li>
          </ul>
          <div class="flex items-center align-middle justify-end mr-3 sm:hidden">
            <!-- Mobile menu button -->
            <button
              phx-click={expand_mobile_menu()}
              class="inline-flex items-center justify-center p-2 rounded-md text-gray-400 hover:text-gray-500 hover:bg-brand-100 focus:outline-none focus:bg-brand-100 focus:text-brand-500 transition duration-150 ease-in-out"
              aria-label="Main menu"
              aria-expanded="false"
            >
              <SVG.pancake />
            </button>
          </div>
        </nav>
        <nav class="secondary hidden sm:hidden">
          <ul>
            <li class="hidden">
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
            <li class="hidden">
              <%= outbound_link to: "https://plausible.io/megalithic.io", title: "Plausible" do %>
                <span class="sr-only">
                  Analytics
                </span>
                <SVG.plausible_small />
              <% end %>
            </li>
          </ul>
        </nav>
      </div>
      <!-- Mobile Menu -->
      <nav id="mobile_menu_content" class="hidden sm:hidden">
        <ul class="bg-mega-bg_dark py-4">
          <li>
            <%= live_redirect("Blog",
              to: Routes.blog_path(@socket, :index),
              class:
                ""
            ) %>
          </li>
          <li>
          <%= live_redirect("Projects",
            to: Routes.page_path(@socket, :about),
            class:
              ""
          ) %>
          </li>
          <li>
          <%= outbound_link("Utilities",
            to: "https://utils.zest.dev",
            class:
              ""
          ) %>
          </li>
        </ul>
      </nav>
    </header>
    """
  end
end
