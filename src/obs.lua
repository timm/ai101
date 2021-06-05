-- vim: ts=2 sw=2 sts=2 et :
-- # Obs.lua
-- Collect obervations and  what ranges are seen where
-- (c) 2021 Tim Menzies (timm@ieee.org) unlicense.org

local Lib, Thing = require("lib"),require("thing")
local Obs=Lib.class(Thing)

function Obs:_init(klass,at,down,up,n,all)
  all = all or {}
  all[klass] = all[klass] or {}
  local tmp = all[klass]
  tmp[#tmp+1] = self
  self.klass,self.at = klass,at
  self.down,self.up,self.n=down,up,n end

function Obs:__eq(other)
  return (self.at   == other.at and  
          self.up   == other.up and
          self.down == other.down) end

function Obs:other(all)
  for _,one in pairs(all) do
    if one==self then return one end end end  

function Obs:score(n1,n2,all)
  other = self:other(all)
  b = self.n/n1
  r = other and other.n/n2 or 0
  return b^2/(b+r) end

function Obs:selects(rows)
  local function has(x)
    if x=="?" then return false end
    if   self.down == self.up 
    then return x==self.down
    else return self.down <= x and x<=self.up end end
  ---------------------------------------------------
  local out={}
  for _,row in pairs(rows) do
    if has(row.cells[self.at]) then out[#out+1]=row end end
  return out end

return Obs
