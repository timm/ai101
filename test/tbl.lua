-- vim: ts=2 sw=2 sts=2 et :
-- testing table routines
-- (c) 2021 Tim Menzies (timm@ieee.org) unlicense.org

package.path = '../src/?.lua;' .. package.path 
local  Tbl, Lib = require("tbl"), require("lib")

do
  local t=Tbl()
  for row in Lib.csv("data/auto93.csv") do t:add(row) end
  assert(8==#t.cols,"length of  lst")
end

Lib.rogues()
