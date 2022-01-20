defmodule MegalithicWeb.PageController do
  use MegalithicWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
