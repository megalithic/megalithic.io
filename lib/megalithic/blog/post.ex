defmodule Megalithic.Blog.Post do
  @enforce_keys [:id, :title, :body, :description, :reading_time, :tags, :date]
  defstruct [
    :id,
    :title,
    :body,
    :description,
    :original_url,
    :reading_time,
    :tags,
    :date,
    :discussion_url,
    published: true
  ]

  def build(filename, attrs, body) do
    [year, month_day_id] =
      filename
      |> Path.rootname()
      |> Path.split()
      |> Enum.take(-2)

    [month, day, slug] = String.split(month_day_id, "-", parts: 3)
    date = Date.from_iso8601!("#{year}-#{month}-#{day}")

    struct!(
      __MODULE__,
      [
        id: slug,
        date: date,
        body: body,
        reading_time: estimate_reading_time(body)
      ] ++ Map.to_list(attrs)
    )
  end

  @avg_wpm 200
  defp estimate_reading_time(body) do
    body
    |> String.split(" ")
    |> Enum.count()
    |> Kernel./(@avg_wpm)
    |> round()
  end
end
