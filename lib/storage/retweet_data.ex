defmodule Storage.RetweetData do
  def sort(library) do
    g = :digraph.new
    Enum.each(library, fn {l,deps} ->
      :digraph.add_vertex(g,l)           # noop if library already added
      Enum.each(deps, fn d -> add_dependency(g,l,d) end)
    end)
    if t = :digraph_utils.topsort(g) do
      print_path(t)
    else
      IO.puts "Unsortable contains circular dependencies:"
      Enum.each(:digraph.vertices(g), fn v ->
        if vs = :digraph.get_short_cycle(g,v), do: print_path(vs)
      end)
    end
  end

  defp print_path(l), do: IO.puts Enum.join(l, " -> ")

  defp add_dependency(_g,l,l), do: :ok
  defp add_dependency(g,l,d) do
    :digraph.add_vertex(g,d)   # noop if dependency already added
    :digraph.add_edge(g,d,l)   # Dependencies represented as an edge d -> l
  end
end
