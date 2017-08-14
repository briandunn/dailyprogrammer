defmodule ThreeSum do
  def find_answers(list) do
    combinations(list, 3)
    |> Enum.filter(fn(combination) ->
      Enum.reduce(combination, 0, &(&1 + &2)) == 0
    end)
  end

  def split_ints(line) do
    line
    |> String.trim_trailing
    |> String.split(" ", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.sort
  end

  def printf(answers) do
    Enum.each(answers, fn(answer)-> IO.puts Enum.join(answer, " ") end)
    IO.puts("")
  end

  def combinations(_, 0), do: [[]]

  def combinations([], _), do: []

  def combinations([ head | tail ], size) do
    (for combination <- combinations(tail, size - 1) do
       [ head | combination ]
    end) ++ combinations(tail, size)
  end

  def process_line do
    case IO.read(:line) do
      :eof -> nil
      line -> line
              |> split_ints
              |> find_answers
              |> Enum.uniq
              |> printf
              process_line()
    end
  end
end

ThreeSum.process_line
