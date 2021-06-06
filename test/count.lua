-- vim: ts=2 sw=2 sts=2 et :
-- Testing observations
-- (c) 2021 Tim Menzies (timm@ieee.org) unlicense.org

package.path = '../src/?.lua;' .. package.path 
local Lib,Count=require("lib"),require("count")

do
  local all={}
  local x=Count(true,4,6,7,10,all)
  local y=Count(true,4,6,7,20,all)
  assert(x==y)
  assert(#all[true] ==2)
end

Lib.rogues()
