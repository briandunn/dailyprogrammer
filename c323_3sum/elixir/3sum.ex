defmodule ThreeSum do
  def find_answers(list) do
    combinations(list, 3)
    |> Enum.filter(fn([a,b,c]) ->
      a + b + c == 0
    end)
  end

  def process_line(line) do
    line
    |> String.trim_trailing
    |> String.split(" ", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.sort
    |> find_answers
    |> Enum.uniq
  end

  def combinations(_, 0), do: [[]]

  def combinations([], _), do: []

  def combinations([ head | tail ], size) do
    (for combination <- combinations(tail, size - 1) do
       [ head | combination ]
    end) ++ combinations(tail, size)
  end

  def printf(answers) do
    for answer <- answers do
      answer
      |> Enum.join(" ")
      |> IO.puts
    end
    IO.puts("")
  end

  def go do
    IO.stream(:stdio, :line)
    |> Task.async_stream(&process_line/1)
    |> Stream.each(fn ({:ok, answers}) -> printf(answers) end)
    |> Enum.to_list
  end
end

ThreeSum.go
