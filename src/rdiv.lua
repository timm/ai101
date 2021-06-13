-- vim: ts=2 sw=2 sts=2 et :
-- # Rdiv.lua
-- Recursively divide the data.   
-- (c) 2021 Tim Menzies (timm@ieee.org) unlicense.org

local r = require
local Lib,Thing,Tbl = r("lib"),r("thing"),r("tbl")
local  div,rdiv

function div(rows,t,the,cols)
  local zero,one,two,c,a,b,mid,left,right
  zero = Lib.any(rows)
  one  = t:faraway(zero, the, cols, rows)
  two  = t:faraway(one,  the, cols, rows)
  c    = one:dist(two, the, cols)
  for _,row in pairs(rows) do
    a  = row:dist(one, the, cols)
    b  = row:dist(two, the, cols)
    row.divx = (a^2 + c^2 - b^2)/(2*c) 
  end
  table.sort(rows, function(y,z) return y.divx < z.divx end)
  mid, left, right = #rows//2, {}, {}
  for n,row in pairs(rows) do
    if   n <= mid 
    then left[ #left +1] = row
    else right[#right+1] = row end end
  return left,right end

function rdiv(rows,lvl,t,the,all,cols,enough)
  local pre, left,right
  if   the.loud 
  then pre="|.. ";print(pre:rep(lvl)..tostring(#rows)) 
  end
  if   #rows < 2*enough 
  then all[#all+1] = t:clone(rows)
  else left,right= div(rows,t,the,cols) 
       rdiv(left, lvl+1,t,the,all,cols,enough) 
       rdiv(right,lvl+1,t,the,all,cols,enough) end  end 

return function (t,the,cols)
  local all = {}
  rdiv(t.rows,0,t,the,all,cols or t.x,(#t.rows)^the.enough)
  table.sort(all)
  return all end
