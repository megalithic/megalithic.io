defmodule MegalithicWeb.Presence do
  use Phoenix.Presence,
    otp_app: :megalithic,
    pubsub_server: Megalithic.PubSub
end
