-- vim: ts=2 sw=2 sts=2 et :
-- # Sym.lua
-- Summarizing symbolic columns.   
-- (c) 2021 Tim Menzies (timm@ieee.org) unlicense.org

local Lib,Col = require("lib"),require("col")
local Sym = Lib.class(Col)

function Sym:_init(at,txt) 
  self:super(at,txt)
  self.seen,self.most,self.mode = {},0,nil end

function Sym:add1(x,   n)
  local d = (self.seen[x] or 0) + (n or 1)
  self.seen[x] = d
  if d > self.most then self.most, self.mode = d, x end end

function Sym:ent(   e,p)
  e = 0
  for _,n in pairs(self.seen) do 
    p = n/self.n
    e = e - p*math.log(p)/math.log(2) end 
  return e end

function Sym:mid(x)     return self.mode  end
function Sym:norm1(x)   return x end
function Sym:dist1(x,y) return x==y and 0 or 1 end
function Sym:spread()   return self:ent() end

function Sym:merge(j)
  local k = Sym(self.at, self.txt)
  for _,seen1 in pairs({self.seen, j.seen}) do
    for x,n in pairs(seen1) do 
      k:add(x,n) end end
  local e1,n1 = self:ent(), self.n
  local e2,n2 = j:ent(),    j.n
  local e ,n  = k:ent(),    k.n
  local xpect = n1/n*e1 + n2/n*e2
  if e<=xpect then return k end end

function Sym:discretize(other,all,_)
  for x,n in pairs(self.seen)  do 
    Obs(true,self.at,x,x,n,all) end
  for x,n in pairs(other.seen)  do 
    Obs(false,self.at,x,x,n,all) end end

return Sym
