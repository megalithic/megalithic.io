defmodule MegalithicWeb.BlogLive do
  use MegalithicWeb, :live_view

  require Logger

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket, temporary_assigns: [posts: [], relevant_posts: [], post: nil, tag: nil]}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  def show(post, socket) do
    socket
    |> assign(:post, post)
    |> maybe_assign_canonical_url(post)
    # FIXME: presently this is failing
    |> track_readers(post)
    |> assign(:relevant_posts, relevant_posts(post))
    |> assign(:breadcrumbs, MegalithicWeb.SEO.Breadcrumbs.build(post))
    |> assign(:og, MegalithicWeb.SEO.OpenGraph.build(post))
    |> assign(:page_title, post.title)
  end

  defp apply_action(socket, :show, %{"id" => id, "preview" => "true"}) do
    id
    |> Megalithic.Blog.get_post_preview_by_id!()
    |> show(socket)
  end

  defp apply_action(socket, :show, %{"id" => id}) do
    id
    |> Megalithic.Blog.get_post_by_id!()
    |> show(socket)
  end

  defp apply_action(socket, :tag, %{"tag" => tag}) do
    posts = Megalithic.Blog.get_posts_by_tag!(tag)

    socket
    |> assign(:tag, tag)
    |> assign(:posts, posts)
    |> assign(:readers, nil)
    |> assign(:page_title, "blog | #{tag}")
  end

  defp apply_action(socket, :index, _params) do
    posts = Megalithic.Blog.published_posts()

    socket
    |> assign(:posts, posts)
    |> assign(:readers, nil)
    |> assign(:page_title, "blog")
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

    readers =
      topic
      |> MegalithicWeb.Presence.list()
      |> map_size()

    if connected?(socket) do
      Logger.debug(
        "websocket_connected for tracking readers: #{inspect({topic, socket.id, post.id})}"
      )

      MegalithicWeb.Endpoint.subscribe(topic)
      MegalithicWeb.Presence.track(self(), topic, socket.id, %{id: socket.id})
    end

    assign(socket, :readers, readers)
  end

  @impl true
  def handle_info(
        %{event: "presence_diff", payload: %{joins: joins, leaves: leaves}},
        %{assigns: %{readers: count}} = socket
      ) do
    readers = count + map_size(joins) - map_size(leaves)

    {:noreply, assign(socket, :readers, readers)}
  end
end
