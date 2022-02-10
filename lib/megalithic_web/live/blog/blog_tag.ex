defmodule MegalithicWeb.BlogTag do
  use MegalithicWeb, :live_component

  def render(assigns) do
    ~H"""
    <div class="posts for-tag">
      <h4 class="subtitle">
        Posts for tag: <pre><%= @tag %></pre>
      </h4>
      <%= for post <- @posts do %>
      <div id={"post-#{post.id}"} class="post">
        <h2 class="title">
          <%= live_redirect(post.title,
            to: Routes.blog_path(@socket, :show, post.id),
            class:
              "transition-colors duration-150 border-transparent border-b-4 focus:border-brand-500 hover:border-accent-500 no-underline"
          ) %>
        </h2>
        <dl class="meta">
          <dt>
            <%= Date.to_iso8601(post.date) %>
          </dt>
          <%= if post.original_url do %>
            <dd class="original-publishing">
              <%= outbound_link("Original Publishing",
                style: "border-bottom-width: 1px",
                class: "hover:border-accent-500 transition-colors duration-150 ease-in-out",
                to: post.original_url
              ) %>
            </dd>
          <% end %>
          <dd class="reading-time">
            <%= post.reading_time %> min to read
          </dd>
          <%= if Enum.any?(post.tags) do %>
            <dd class="tags">
              <%= Enum.join(post.tags, ", ") %>
            </dd>
          <% end %>
        </dl>
        <p class="description">
          <%= raw(post.description) %>
        </p>
        <div class="feedback">
          <%= live_redirect("Read more...",
            to: Routes.blog_path(@socket, :show, post.id)
          ) %>
        </div>
      </div>
      <% end %>
    </div>
    """
  end
end
