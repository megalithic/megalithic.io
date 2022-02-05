defmodule Megalithic.Blog.Markdown do
  def post_processor({"pre", attrs, _children, meta}) do
    {"pre", [{"class", "highlight"} | attrs], ["nope"], meta}
  end

  # def post_processor({"code", attrs, children, meta} = _node) do
  #   attrs = [{"class", "whatup"} | attrs]
  #   children |> to_string() |> Makeup.highlight()

  #   {"code", attrs, ["farts"], meta}
  # end

  def post_processor(other), do: other

  def to_html(string) do
    Earmark.as_html!(string, compact_output: true, postprocessor: &__MODULE__.post_processor/1)
  end
end
