defmodule MegalithicWeb.BlogShow do
  # use MegalithicWeb, :live_component

  import MegalithicWeb.Components.Link

  use Phoenix.Component
  use Phoenix.HTML
  alias MegalithicWeb.Router.Helpers, as: Routes

  def show(assigns) do
    ~H"""
    <div class="post-container">
      <p class="post-nav hidden">
        <%= live_redirect to: Routes.blog_path(MegalithicWeb.Endpoint, :index), class: "" do %>
          <svg
            class="-ml-0.5 mr-2 w-5 h-5 flex"
            xmlns="http://www.w3.org/2000/svg"
            fill="none"
            viewBox="0 0 24 24"
            stroke="currentColor"
          >
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M7 16l-4-4m0 0l4-4m-4 4h18"
            />
          </svg>
          all posts
        <% end %>
      </p>
      <article id={"post-#{@post.id}"} class="post">
        <h2><%= @post.title %></h2>
        <dl class="meta">
          <dt>Published on <%= Date.to_iso8601(@post.date) %></dt>
          <%= if @post.original_url do %>
            <dd class="original-publishing">
              <.link class="border-b-2 hover:border-accent-500 transition-colors duration-150 ease-in-out" to={@post.original_url}>Original Publishing</.link>
            </dd>
          <% end %>
            <dd class="reading-time">
              <%= @post.reading_time %>min to read
            </dd>
          <%= if not is_nil(@readers) and @readers > 1 do %>
            <dd class="current-readers">
              <%= @readers %> current readers
            </dd>
          <% end %>
          <%= if Enum.any?(@post.tags) do %>
            <dd class="tags">
              <%= for tag <- @post.tags do %>
                <span class="tag"><a href={"/blog/tags/#{tag}"}><i class="bi-tag"></i> <%= tag %></a></span>
                <%= # Enum.join(@post.tags, ", ") %>
              <% end %>
            </dd>
          <% end %>
        </dl>
        <div id={"post-content-#{@post.id}"} phx-hook="Highlight" phx-update="ignore" class="content">
          <%= raw(@post.body) %>
        </div>
      </article>
      <div class="feedback">
        <p class="mt-4 mb-10">
          I'd love to hear from you, <.link to="https://twitter.com/megalithic">get @ me on twitter</.link>.
          <%= if @post.discussion_url do %> or <.link to={@post.discussion_url}>leave a comment at GitHub</.link><% end %>
        </p>
      </div>
      <%= if Enum.any?(@relevant_posts) do %>
        <div class="block print:hidden">
          <hr class="my-8" />
          <h3 class="text-lg leading-10 font-medium">
            Other articles that may interest you
          </h3>
          <div class="flex flex-wrap mt-4 mb-10 justify-between">
            <%= for relevant_post <- @relevant_posts do %>
              <div class="w-full p-2 lg:w-1/2">
                <%= live_redirect to: Routes.blog_path(@socket, :show, relevant_post.id), class: "" do %>
                  <svg viewBox="0 0 20 20" fill="currentColor" class="mr-2 fill-current w-6 h-6">
                    <path
                      fill-rule="evenodd"
                      d="M12.586 4.586a2 2 0 112.828 2.828l-3 3a2 2 0 01-2.828 0 1 1 0 00-1.414 1.414 4 4 0 005.656 0l3-3a4 4 0 00-5.656-5.656l-1.5 1.5a1 1 0 101.414 1.414l1.5-1.5zm-5 5a2 2 0 012.828 0 1 1 0 101.414-1.414 4 4 0 00-5.656 0l-3 3a4 4 0 105.656 5.656l1.5-1.5a1 1 0 10-1.414-1.414l-1.5 1.5a2 2 0 11-2.828-2.828l3-3z"
                      clip-rule="evenodd"
                    ></path>
                  </svg>
                  <span>
                    <%= relevant_post.title %>
                  </span>
                <% end %>
              </div>
            <% end %>
          </div>
        </div>
      <% end %>
    </div>
    """
  end
end
