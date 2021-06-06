-- vim: ts=2 sw=2 sts=2 et :
-- testing recursive contrast sets
-- (c) 2021 Tim Menzies (timm@ieee.org) unlicense.org

package.path = '../src/?.lua;' .. package.path 
local r=require
local  Tbl, Lib, contrast = r("tbl"), r("lib"), r("contrast")

local function _t1(f)
  local the =Lib.the()
  local t=Tbl()
  for row in Lib.csv(f or the.data) do t:add(row) end
  table.sort(t.rows)
  local n = #t.rows
  local m = n^.5 // 1
  local bests,rests = t:clone(),t:clone()
  for i=1,m   do bests:add(t.rows[i]) end
  for i=m+1,n do rests:add(t.rows[i]) end
  print(Lib.oo(t:goals()),"all")
  print(Lib.oo(bests:goals()),"best")
  print(Lib.oo(rests:goals()),"rest")
  contrast(t,the,t.x)
end

_t1()
Lib.rogues()
