defmodule MegalithicWeb.RobotView do
  use MegalithicWeb, :view

  @generic %MegalithicWeb.SEO.Generic{}

  def render("robots.txt", %{env: :prod}), do: ""

  def render("robots.txt", %{env: _}) do
    """
    User-agent: *
    Disallow: /
    """
  end

  def render("rss.xml", %{}) do
    MegalithicWeb.Rss.generate(%MegalithicWeb.Rss{
      title: @generic.title,
      author: "Seth Messer",
      description: @generic.description,
      posts: Megalithic.Blog.published_posts()
    })
  end
end
