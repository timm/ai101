-- vim: ts=2 sw=2 sts=2 et :
-- testing table routines
-- (c) 2021 Tim Menzies (timm@ieee.org) unlicense.org

package.path = '../src/?.lua;' .. package.path 
Tbl=require("tbl")
Lib=require("lib")

do
  local t=Tbl()
  for row in Lib.csv("data/weather.csv") do t:add(row) end
end

Lib.rogues()
