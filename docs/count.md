
# Count.lua
Collect observations and  what ranges are seen where
(c) 2021 Tim Menzies (timm@ieee.org) unlicense.org

```lua

local Lib, Thing = require("lib"),require("thing")
local Count=Lib.class(Thing)

function Count:_init(klass,txt,at,down,up,n,counts)
  if counts then
    counts[klass] = counts[klass] or {}
    local tmp = counts[klass]
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
  return false
end

function Count:__eq(other)
  return (self.at   == other.at and  
          self.up   == other.up and
          self.down == other.down) end

function Count:other(counts)
  for k,counts in pairs(counts) do
    if k ~= self.klass then
      for _,count in pairs(counts) do
        if one==self then return one end end end end end  

function Count:selects(rows)
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

return Count
```
