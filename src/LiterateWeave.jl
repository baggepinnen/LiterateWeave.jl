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
```
"""
function literateweave(source, args...; kwargs...)
    tmpname = tempname()
    Literate.markdown(source, tmpname, documenter=false)
    sourcename = replace(source, ".jl"=>".md")
    sourcename = match(r"(\w+.md)", sourcename)[1]
    sourcename = joinpath(tmpname,sourcename)
    jmdsource = replace(sourcename,".md"=>".jmd")
    run(`cp $(sourcename) $(jmdsource)`)
    weave(jmdsource, args...; kwargs...)
end

end # module
