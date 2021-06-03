

```lua
-- vim: ts=2 sw=2 sts=2 et :
-- Recursively divide the data.
-- (c) 2021 Tim Menzies (timm@ieee.org) unlicense.org

local r = require
local Lib,Thing,Tbl = r("lib"),r("thing"),r("tbl")

local Tbl = Lib.class()

local function rdiv(t,the,cols)
  all    = {}
  cols   = cols or t.x
  enough = (#t.rows)^the.enough
  local function recurse(rows,lval)
    if   the.loud 
    then local pre="|.. "; print(pre:rep(lvl) .. tostring(#rows)) 
    end
    if   #rows < 2*enough 
    then all[#all+1] = t:clone(rows)
    else local one,row, three,mid,left,rigth,what
         one  = Lib.any(rows)
         two  = t:faraway(one, the, cols, rows)
         three= t:faraway(two, the, cols, rows)
         for _,row in pairs(rows) do
           a = row:dist(two,   the, cols)
           b = row:dist(three, the, cols)
           row.x = (a^2 + c^2 - b^2)/(2*c) 
         end
         table.sort(rows, function(y,z) return y.x < z.x end)
         mid, left, right = rows[#rows//2], {}, {}
         for _,row in pairs(rows) do
           what = row.rdiv <= mid and left or right
           what[#what+1] = row end
         recurse(left, lvl+1) 
         recurse(right,lvl+1)
      end end
  recurse(t.rows,0)
  return all end
```
