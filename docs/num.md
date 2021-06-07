
# Num.lua
Summarizing numeric columns.   
(c) 2021 Tim Menzies (timm@ieee.org) unlicense.org

```lua

local r=require
local Lib,Col,Bin,Count = r("lib"),r("col"),r("bin"),r("count")
local o = Lib.o

local Num = Lib.class(Col)

function Num:_init(at,txt) 
  self:super(at,txt)
  self.mu,self.m2,self.lo,self.hi = 0,0,1E31,-1E31 
  self._all = {}
end

function Num:add1(x,_) 
  self._all[1+#self._all] = x
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
```

Build `xy` pairs from me and other,
cut the numerics, combing splits when the combination
has similar class distributions to the parts.

```lua
function Num:discretize(other,counts,the)
  -- initial a list of pairs
  local xy={}
  for _,x in pairs(self._all)  do xy[#xy+1] = {x,true} end
  for _,x in pairs(other._all) do xy[#xy+1] = {x,false} end
  -- split the list
  local sd = (self.sd*self.n + other.sd*self.n) / (self.n+other.n)
  local bins= Bin.div(xy, sd*the.cohen, (#xy)^the.enough)
  if #bins>1 then
    -- return one Count per bin.
    for _,bin in pairs(bins) do
      for klass,n in pairs(bin.also.seen) do
        Count(klass,self.txt,self.at,bin.down,bin.up,n,counts) end end end end

return Num
```
