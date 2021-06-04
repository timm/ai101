-- vim: ts=2 sw=2 sts=2 et :
-- testing table routines
-- (c) 2021 Tim Menzies (timm@ieee.org) unlicense.org

package.path = '../src/?.lua;' .. package.path 
local  Tbl, Lib = require("tbl"), require("lib")

local function _t1()
  local t=Tbl()
  for row in Lib.csv("data/auto93.csv") do t:add(row) end
  local the=Lib.the()
  print(#t.cols)
  print(#t.x)
  print(#t.y)
  for _,col in  pairs(t.x) do Lib.o(col); print(""); end
  assert(8==#t.cols,"length of  lst")
  return t,the
end

local r2=function(z) return z end
local function _t2()
  local t,the = _t1()
  for n,row in pairs(t.rows) do
    local l=t:neighbors(row,the)
    print("")
    print(Lib.oo(l[1][2].cells), r2(l[1][1]))
    print(Lib.oo(l[2][2].cells), r2(l[2][1]))
    print(Lib.oo(l[#l][2].cells),r2(l[#l][1]))
  end
end

_t2()
Lib.rogues()
