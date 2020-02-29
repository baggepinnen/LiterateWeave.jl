module LiterateWeave

using Literate, Weave

export literateweave, set_chunk_defaults, restore_chunk_defaults

"""
    literateweave(source, args...; kwargs...)

Converts the source .jl file to markdown using Literate.jl and then weaves this markdown file using Weave.jl. Write your code file as if you were using Literate.jl

Args and kwargs goes to weave(s, args...; kwargs...)

- Weave docs: http://weavejl.mpastell.com/stable/
- Literate docs: https://fredrikekre.github.io/Literate.jl/latest/
- Filter a line: `#src`
- Comment in code: `##`

Default weave options can be modified, try
```julia
set_chunk_defaults(Dict(
:dpi        => 96,
:fig        => true,
:fig_pos    => nothing,
:out_width  => nothing,
:label      => nothing,
:eval       => true,
:wrap       => true,
:fig_env    => nothing,
:term       => false,
:hold       => false,
:cache      => false,
:include    => true,
:prompt     => "\njulia> ",
:results    => "markup",
:out_height => nothing,
:tangle     => true,
:display    => false,
:fig_width  => 6,
:engine     => "julia",
:fig_path   => "figures",
:line_width => 75,
:skip       => false,
:fig_height => 4,
:echo       => true,
:fig_cap    => nothing,
:fig_ext    => nothing))
```
Standard usage:
```julia
literateweave("myfile.jl", doctype="md2pdf", latex_cmd="lualatex")
```
"""
function literateweave(source, args...; kwargs...)
    tmpname = tempname()
    Literate.markdown(source, tmpname, documenter=false)
    if source[end-1:end] == "jl"
      sourcename = source[1:end-2] * "md"
    else
      @error "Need .jl file!"
    end
    sourcename = match(r"(\w+.md)", sourcename)[1]
    sourcename = joinpath(tmpname,sourcename)
    jmdsource = replace(sourcename,".md"=>".jmd")
    run(`cp $(sourcename) $(jmdsource)`)
    weave(jmdsource, args...; kwargs...)
end

end # module
