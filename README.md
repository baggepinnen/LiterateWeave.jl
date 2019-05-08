# LiterateWeave.jl

This package automatically runs a julia source file and converts it to, e.g., a pdf or html while capturing output such as figures and text.

We convert a source `.jl` file to markdown using [Literate.jl](https://github.com/fredrikekre/Literate.jl) and then weaves this markdown file to, e.g., pdf or html, using [Weave.jl](https://github.com/mpastell/Weave.jl). Write your code file as if you were using Literate.jl

This package exports a single function
```julia
literateweave(source, args...; kwargs...)
```
`args` and `kwargs` goes to `weave(s, args...; kwargs...)`

## Example
```julia
literateweave("myfile.jl", doctype="md2pdf")
```

## Notes
- Figures are captured by Weave. If you have multiple plot commands producing multiple plots, separate them by `#`, e.g.:
```julia
plot(...)
#
plot(...)
```

- The Juno cell-separator `##` confuses Literate and produces an invalid character which causes Weave to fail.
- Inline latex math is supported using `$x+y$`

## Why a package
I created this package to solve the following problem:

Literate.jl allows me to write code as normal and insert normal comments, and then converting this code to markdown. Unfortunately, Literate does not run the code or capture output.

Weave.jl does run the code and capture the output, but requires you to write a `.jmd` file which is much less convenient to work with compared to a normal julia source file, which is often what you start out with.

## Credits
All credits goes to the creators of Literate.jl and Weave.jl. This package just glues them together.
