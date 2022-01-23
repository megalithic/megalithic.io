defmodule MegalithicWeb.LayoutView do
  use MegalithicWeb, :view
  alias Phoenix.LiveView.JS

  # Phoenix LiveDashboard is available only in development by default,
  # so we instruct Elixir to not warn if the dashboard route is missing.
  @compile {:no_warn_undefined, {Routes, :live_dashboard_path, 2}}

  def expand_mobile_menu do
    JS.toggle(to: "#MobileMenuContent")
    |> JS.toggle(to: "#MobileMenuIconOpen")
    |> JS.toggle(to: "#MobileMenuIconClose")
  end
end
