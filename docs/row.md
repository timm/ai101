
# Row.lua
Handling  one example in a table.   
(c) 2021 Tim Menzies (timm@ieee.org) unlicense.org

```lua

local Lib,Thing = require("lib"),require("thing")

```

Create

```lua
local Row = Lib.class(Thing)

function Row:_init(t,cells)
  self._tab, self.cells = t,cells end
```

Distance

```lua
function Row:dist(other,the,cols)
  local d,n=0,1E-32
  for _,col in pairs(cols or self._tab.x) do
    local inc = col:dist(self.cells[col.at], other.cells[col.at])
    d = d + inc^the.p
    n = n + 1 end
  return (d/n)^the.p end

```

dominate

```lua
function Row:__lt(other,   s1,s2,n,a,b,s1,s2)
  s1, s2, n = 0, 0, #self._tab.y
  for _,col in pairs(self._tab.y) do
    a   = col:norm(self.cells[col.at])
    b   = col:norm(other.cells[col.at])
    s1  = s1 - Lib.e^(col.w * (a - b) / n)
    s2  = s2 - Lib.e^(col.w * (b - a) / n) end
  return s1 / n < s2 / n end
```

Export

```lua
return Row
```
