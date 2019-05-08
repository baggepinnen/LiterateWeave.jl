# LiterateWeave.jl

We convert a source `.jl` file to markdown using [Literate.jl](https://github.com/fredrikekre/Literate.jl) and then weaves this markdown file to, e.g., pdf or html, using [Weave.jl](https://github.com/mpastell/Weave.jl). Write your code file as if you were using Literate.jl

This package exports a single function
```julia
literateweave(source, args...; kwargs...)
```
`args` and `kwargs` goes to `weave(s, args...; kwargs...)`

Try
```julia
literateweave("myfile.jl", doctype="md2pdf")
```
