defmodule MegalithicWeb.Components.Footer do
  use MegalithicWeb, :live_component

  alias MegalithicWeb.Components.SVG
  alias MegalithicWeb.Router.Helpers, as: Routes

  @impl true

  def render(assigns) do
    ~H"""
    <footer class="footer">
      <nav>
        <ul>
          <li class="hidden">
            <select id="themeChooser" class="dark:border-gray-800 border-gray-200 focus:ring-gray-500 focus:border-brand-500 ml-6 py-1 pl-2 pr-4 border-red bg-transparent text-gray-500 sm:text-sm rounded-md">
              <option disabled>Site theme</option>
              <template x-for="theme in colorThemes" :key="theme">
                <option :value="theme" x-text="theme" :selected="currentTheme === theme"></option>
              </template>
            </select>
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
            <%= outbound_link to: "https://www.linkedin.com/in/seth-messer/", title: "LinkedIn" do %>
              <span class="sr-only">
                LinkedIn
              </span>
              <SVG.linkedin_small />
            <% end %>
          </li>
          <li>
            <%= outbound_link to: "mailto:seth@megalthic.io", title: "Email me" do %>
              <span class="sr-only">
                Email me
              </span>
              <SVG.email_small />
            <% end %>
          </li>
          <li class={if @live_action === :home, do: "hidden"}>
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
      <div class="copyright">&copy; 2002 - <%= DateTime.utc_now().year %> megalithic industries (seth messer)
        <span class="hidden print:inline">
          megalithic.io
        </span>
      </div>
    </footer>
    """
  end
end
