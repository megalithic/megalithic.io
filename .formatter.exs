[
  plugins: [Phoenix.LiveView.HTMLFormatter],
  import_deps: [:phoenix, :ecto_sql, :ecto, :typed_struct, :typed_ecto_schema],
  inputs: ["*.{heex,ex,exs}", "{config,lib,test}/**/*.{heex,ex,exs}"],
  subdirectories: ["priv/*/migrations"],
  heex_line_length: 300
]
