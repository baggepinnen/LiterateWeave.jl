module LiterateWeave

using Literate, Weave

export literateweave

"""
    literateweave(source, args...; kwargs...)

Converts the source .jl file to markdown using Literate.jl and then weaves this markdown file using Weave.jl. Write your code file as if you were using Literate.jl

Args and kwargs goes to weave(s, args...; kwargs...)
Try
```julia
literateweave("myfile.jl", doctype="md2pdf")
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
