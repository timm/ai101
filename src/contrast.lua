-- vim: ts=2 sw=2 sts=2 et :
-- # Rcontrast.lua
-- Recursively prune data using  min maximal delta between halves.  
-- (c) 2021 Tim Menzies (timm@ieee.org) unlicense.org

local r = require
local Lib,Thing,Tbl = r("lib"),r("thing"),r("tbl")

local function constrast(t,the,cols)
  cols = cols or t.x
  local all    = {}
  local enough = (#t.rows)^the.enough
  local function split(t1,lvl)
    if   the.loud 
    then local pre="|.. ";print(pre:rep(lvl)..tostring(t1.rows)) end
    if   #t1.rows < 2*enough 
    then all[#all+1] = t1
    else local zero,one,two,c,a,b
         zero = Lib.any(t1.rows)
         one  = t:faraway(zero, the, cols, t1.rows)
         two  = t:faraway(one,  the, cols, t1.rows)
         c    = one:dist(two, the, cols)
         for _,row in pairs(t1.rows) do
           a  = row:dist(one, the, cols)
           b  = row:dist(two, the, cols)
           row.x = (a^2 + c^2 - b^2)/(2*c) 
         end
         table.sort(rows, function(y,z) return y.x < z.x end)
         local mid, left, right = #t1.rows//2, {}, {}
         local lefts,rights = t.clone(), t.clone()
         for n,row in pairs(t1.rows) do
           if   n <= mid 
           then lefts:add(row)
           else rights:add(row) end 
         return lefts,rights end end end

  local function reflect(lefts,rights)
    local all={}
    for n,left in pairs(lefts.x) do
      right = rights.x[n]
      left:discetize(right,all,the)
    end
    for _,one in pairs(all) do
      one.rank = one:score(#lefts.rows, #rights.rows, all) end
    table.sort(all, function(x,y) return x[1].rank < y[1].rank end) end 
    Lib.o(all[1]) end

return  rdiv
