-- vim: ts=2 sw=2 sts=2 et :
-- # Count.lua
-- Collect observations and  what ranges are seen where
-- (c) 2021 Tim Menzies (timm@ieee.org) unlicense.org

local Lib, Thing = require("lib"),require("thing")
local Count=Lib.class(Thing)

function Count:_init(klass,txt,at,down,up,n,counts,    tmp)
  if counts then
    counts[klass] = counts[klass] or {}
    tmp = counts[klass]
    tmp[#tmp+1] = self
  end
  self.klass,self.at, self.txt = klass,at,txt
  self.down,self.up,self.n=down,up,n end

function Count:__tostring()
  return Lib.fmt("%s %s(%s) (%5g ,, %5g) %s",
     self.klass, self.txt, self.at, self.down, self.up, self.n) end

function Count:__lt(other)
  if self.at < other.at then return true  end
  if self.at==other.at and self.down<other.down then return true end
  return false end

function Count:__eq(other)
  return (self.at   == other.at and  
          self.up   == other.up and
          self.down == other.down) end

function Count:other(counts)
  for k,counts in pairs(counts) do
    if k ~= self.klass then
      for _,count in pairs(counts) do
        if one==self then return one end end end end end  

function Count:selects(rows,     has,out)
  function has(x)
    if x=="?" then return false end
    if   self.down == self.up 
    then return x==self.down
    else return self.down <= x and x<=self.up end end
  ---------------------------------------------------
  out={}
  for _,row in pairs(rows) do
    if has(row.cells[self.at]) then out[#out+1]=row end end
  return out end

-- local function like(lst,kl,hs,counts,the)
--     n = hs[true] + hs[false]
--     prior = (hs[kl] + the.k) / (n + the.k * 2)
--     fs = {}
--     for _,x in pairs(lst):
--       fs[x.txt] = fs.get(x.txt, 0) + f.get((kl, (txt, pos, span)), 0)
--     like = prior
--     for val in fs.values(): 
--       like *= (val + my.m*prior) / (hs[kl] + my.m)
--     return like
--
--   def value(lst):
--     b = like(lst, True)
--     r = like(lst, False)
--     if my.act ==3:
--       return 1/(b+r)
--     if my.act ==2:
--       return r**2 / (b + r) if (b+r) > 0.01 and r > b else 0
--     else: 
--       return b**2 / (b + r) if (b+r) > 0.01 and b > r else 0
--

return Count
