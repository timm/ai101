
# Rdiv.lua
Recursively divide the data.   
(c) 2021 Tim Menzies (timm@ieee.org) unlicense.org

```lua
local r = require
local Lib,Thing,Tbl = r("lib"),r("thing"),r("tbl")
local rdiv

```

If there are two few rows, then make a new leaf cluster.
Else, divide the data into two and recurse on each half.

```lua
function rdiv(rows,lvl,t,the,leafs,cols,enough,
              pre, left,right)
  if   the.loud 
  then pre="|.. ";print(pre:rep(lvl)..tostring(#rows)) 
  end
  if   #rows < 2*enough 
  then leafs[#leafs+1] = t:clone(rows)
  else left,right= t:div2(the,cols,rows)
       rdiv(left, lvl+1,t,the,leafs,cols,enough) 
       rdiv(right,lvl+1,t,the,leafs,cols,enough) end  end 
```

Returns the leaf clusters, sorted by their median value
(so the first leaf is much better than the last leaf).

```lua
return function (t,the,cols,      leafs)
  leafs={}
  rdiv(t.rows,0,t,the,leafs,cols or t.x,(#t.rows)^the.enough)
  table.sort(leafs)
  return leafs end
```
