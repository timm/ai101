-- vim: ts=2 sw=2 sts=2 et :
-- # Num.lua
-- Summarizing numeric columns.
-- (c) 2021 Tim Menzies (timm@ieee.org) unlicense.org

local Lib,Col = require("lib"),require("col")
local Num = Lib.class(Col)

function Num:_init(at,txt) 
  self:super(at,txt)
  self.mu,self.m2,self.lo,self.hi = 0,0,1E31,-1E31 
  self._all = {}
end

function Num:add1(x,_) 
  self._all[(#self._all)+1] = x
  local d = x - self.mu
  self.mu = self.mu + d/self.n
  self.m2 = self.m2 + d*(x - self.mu)
  if x > self.hi then self.hi = x end
  if x < self.lo then self.lo = x end
  self.sd = (self.n  < 2 and 0 or (
             self.m2 < 0 and 0 or (
            (self.m2/(self.n-1)))))^0.5 end

function Num:dist1(x,y)
  if      x=="?" then y   = self:norm(y); x=y<0.5 and 1 or 0 
  else if y=="?" then x   = self:norm(x); y=x<0.5 and 1 or 0
  else                x,y = self:norm(x), self:norm(y) end end
  return  math.abs(x - y) end

function Num:mid(x)    return self.mu end
function Num:norm1(x)  return (x-self.lo)/(self.hi-self.lo+1E-32) end
function Num:spread(x) return self.sd end

function Num:discretize(other,us,them,the)
  local xy={}
  for _,x in pairs(self._all)  do xy[#xy+1] = {x,True} end
  for _,x in pairs(other._all) do xy[#xy+1] = {x,False} end
  local sd = (self.sd*self.n + other.sd*self.n) / (self.n+other.n)
  for _,bin in merge(div(xy, sd*the.cohen, (#xy)^the.enough)) do
    if not (bin.down == -1E32 and bin.up == 1E32) then
      for klass,count in pairs(bin.also.seen) do
        local key = {self.at, bin.down, bin.up}
        if   klass 
        then us[key]   = count
        else them[key] = count end end end end end

return Num
