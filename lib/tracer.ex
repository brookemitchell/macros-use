defmodule Tracer do
  def dump_args(args) do
    args |> Enum.map(&inspect/1) |> Enum.join(", ")
  end

  def dump_defn(name, args) do
    "#{name}(#{dump_args(args)})"
  end

  defmacro def({:when, _, [{name, _, args} = definition, guards]},
             do: content
           ) do
    quote do
      Kernel.def unquote(definition) when unquote(guards) do
        IO.puts("==> call    #{Tracer.dump_defn(unquote(name), unquote(args))}")
        result = unquote(content)
        IO.puts("<== result: #{result}")
        result
      end
    end
  end

  defmacro def({name, _, args} = definition, do: content) do
    quote do
      Kernel.def unquote(definition) do
        IO.puts("==> call    #{Tracer.dump_defn(unquote(name), unquote(args))}")
        result = unquote(content)
        IO.puts("<== result: #{result}")
        result
      end
    end
  end

  defmacro __using__(_opts) do
    quote do
      import Kernel, except: [def: 2]
      import unquote(__MODULE__), only: [def: 2]
    end
  end
end
