defmodule MegalithicWeb.BlogLive do
  use MegalithicWeb, :live_view

  def mount(%{"id" => id, "preview" => "true"}, _session, socket) do
    id
    |> Megalithic.Blog.get_post_preview_by_id!()
    |> show(socket)
  end

  def mount(%{"id" => id}, _session, socket) do
    id
    |> Megalithic.Blog.get_post_by_id!()
    |> show(socket)
  end

  def mount(_params, _session, socket) do
    posts = Megalithic.Blog.published_posts()

    {:ok,
     socket
     |> assign(:posts, posts)
     |> assign(:page_title, "Blog"), temporary_assigns: [posts: []]}
  end

  def handle_params(_params, _session, socket) do
    {:noreply, socket}
  end

  def show(post, socket) do
    {:ok,
     socket
     |> assign(:post, post)
     |> maybe_assign_canonical_url(post)
     |> track_readers(post)
     |> assign(:relevant_posts, relevant_posts(post))
     |> assign(:breadcrumbs, MegalithicWeb.SEO.Breadcrumbs.build(post))
     |> assign(:og, MegalithicWeb.SEO.OpenGraph.build(post))
     |> assign(:page_title, post.title), temporary_assigns: [relevant_posts: [], post: nil]}
  end

  defp maybe_assign_canonical_url(socket, %{original_url: url}) when url not in ["", nil] do
    assign(socket, :canonical_url, url)
  end

  defp maybe_assign_canonical_url(socket, _post), do: socket

  defp relevant_posts(post) do
    post.tags
    |> Enum.shuffle()
    |> List.first()
    |> Megalithic.Blog.get_posts_by_tag!()
    |> Enum.reject(&(&1.id == post.id || !&1.published))
    |> Enum.shuffle()
    |> Enum.take(2)
  end

  defp track_readers(socket, post) do
    topic = "blogpost:#{post.id}"
    readers = topic |> MegalithicWeb.Presence.list() |> map_size()

    if connected?(socket) do
      MegalithicWeb.Endpoint.subscribe(topic)
      MegalithicWeb.Presence.track(self(), topic, socket.id, %{id: socket.id})
    end

    assign(socket, :readers, readers)
  end

  def handle_info(
        %{event: "presence_diff", payload: %{joins: joins, leaves: leaves}},
        %{assigns: %{readers: count}} = socket
      ) do
    readers = count + map_size(joins) - map_size(leaves)
    {:noreply, assign(socket, :readers, readers)}
  end
end
