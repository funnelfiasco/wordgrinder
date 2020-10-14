require("tests/testsuite")

local tempfile = io.tmpfile()
tempfile:write([[
This is paragraph 1.
This is 2.

This is 4 (3 was blank).
]])

tempfile:seek("set", 0)
tempfile:flush()
local document = Cmd.ImportTextFileFromStream(tempfile)

local expected = [[
%% This document automatically generated by WordGrinder 0.8.
\documentclass{article}
\usepackage{xunicode, setspace, xltxtra}
\sloppy
\onehalfspacing
\begin{document}
\title{imported}
\author{(no author)}
\maketitle
This is paragraph 1.

This is 2.

\paragraph{}

This is 4 (3 was blank).

\end{document}
]]

DocumentSet:addDocument(document, "imported")
DocumentSet:setCurrent("imported")
local output = Cmd.ExportToLatexString()
AssertEquals(expected, output)

