[
  plugins: [HeexFormatter],
  import_deps: [:ecto, :phoenix],
  # "posts/*.{md,markdown}"
  inputs: [
    "{mix,.formatter}.exs",
    "*.{ex,exs}",
    "priv/*/seeds.exs",
    "{config,lib,test}/**/*.{ex,exs}",
    "lib/**/*.html.heex"
  ],
  subdirectories: ["priv/*/migrations"]
]
