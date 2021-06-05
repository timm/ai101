-- vim: ts=2 sw=2 sts=2 et :
-- Testing observations
-- (c) 2021 Tim Menzies (timm@ieee.org) unlicense.org

package.path = '../src/?.lua;' .. package.path 
local Lib,Obs=require("lib"),require("obs")

do
  local all={}
  local x=Obs(true,4,6,7,10,all)
  local y=Obs(true,4,6,7,20,all)
  Lib.o(all)
end

Lib.rogues()
