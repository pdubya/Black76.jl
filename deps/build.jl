using BinDeps
using Compat
import Base.Sys.WORD_SIZE

# version of cubature package to use
letsberational="1.0.0.1203"
tagfile = "installed_vers"

if !isfile(tagfile) || readchomp(tagfile) != "$letsberational $WORD_SIZE"
    info("Installing Let's be rational library...")
    cd("src") do
        run(`make`)
    end
    open(tagfile, "w") do f
        println(f, "$letsberational $WORD_SIZE")
    end
else
    info("Let's be rational $letsberational is already installed.")
end
