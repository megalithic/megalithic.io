defmodule MegalithicWeb.ErrorViewTest do
  import Plug.Conn
  import Phoenix.ConnTest
  # import Phoenix.LiveViewTest
  @endpoint MyEndpoint

  use MegalithicWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  # test "renders 404.html" do
  #   assert render_to_string(MegalithicWeb.ErrorView, "404.html", []) == "Not Found"
  # end

  test "renders 500.html" do
    assert render_to_string(MegalithicWeb.ErrorView, "500.html", []) ==
             "Yoinks, somethings broke! (internal server error)"
  end
end
