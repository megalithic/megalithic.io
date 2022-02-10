defmodule MegalithicWeb.BlogLiveTest do
  import Plug.Conn
  import Phoenix.ConnTest
  import Phoenix.LiveViewTest
  @endpoint MegalithicWeb.Endpoint

  use MegalithicWeb.ConnCase, async: true

  test "it renders the page", %{conn: conn} do
    {:ok, _view, html} = live(conn, "/blog")
    assert html =~ "megalithic industries"
  end
end
