-- vim: ts=2 sw=2 sts=2 et :
-- testing table routines
-- (c) 2021 Tim Menzies (timm@ieee.org) unlicense.org

package.path = '../src/?.lua;' .. package.path 
r=require
local  Tbl, Lib,rdiv = r("tbl"), r("lib"),r("rdiv")

local function _t1()
  local t=Tbl()
  for row in Lib.csv("data/auto93.csv") do t:add(row) end
  local the=Lib.the()
  rdiv(t,the,t.y)
end

_t1()
Lib.rogues()
