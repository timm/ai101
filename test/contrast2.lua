-- vim: ts=2 sw=2 sts=2 et :
-- testing recursive contrast sets
-- (c) 2021 Tim Menzies (timm@ieee.org) unlicense.org

package.path = '../src/?.lua;' .. package.path 
local r=require
local  Tbl, Lib, contrast = r("tbl"), r("lib"), r("contrast2")

local out=function(t) print(Lib.oo(Lib.rs(t:goals()))) end

local function _go(f,     the,t,one,two)
  the= Lib.the()
  t=   Tbl()
  for row in Lib.csv(f or the.data) do t:add(row) end
  for klass,one in pairs(contrast(t, the, t.x)) do
    for _,two in pairs(one) do
      print(klass, Lib.oo(two)) end end end

_go()
Lib.rogues()
