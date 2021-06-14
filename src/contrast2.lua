-- vim: ts=2 sw=2 sts=2 et :
-- # Rdiv.lua
-- Recursively divide the data.   
-- (c) 2021 Tim Menzies (timm@ieee.org) unlicense.org
local r = require
local Lib,Thing,Tbl = r("lib"),r("thing"),r("tbl")
local rand= Lib.rand
local rdiv,discretize

function discretize(lefts,rights,the,     counts,right)
  counts={}
  for n,left in pairs(lefts.x) do
    right = rights.x[n]
    left:discretize(right,counts,the)
  end
  return counts
end

-- If there are two few rows, then make a new leaf cluster.
-- Else, divide the data into two and recurse on each half.
function rdiv(rows,lvl,t,the,leafs,cols,todo,enough,
              pre, left,right)
  if   the.loud 
  then pre="|.. ";print(pre:rep(lvl)..tostring(#rows)) 
  end
  if   #rows < 2*enough 
  then leafs[#leafs+1] = t:clone(rows)
  else 
    left,right= t:div2(the,cols,rows)
    if     todo==3 
    then   rdiv(left,  lvl+1,t,the,leafs,cols,1,enough) 
           rdiv(right, lvl+1,t,the,leafs,cols,2,enough) 
    else 
      if   todo==1
      then rdiv(left,  lvl+1,t,the,leafs,cols,todo,enough) 
      else rdiv(right, lvl+1,t,the,leafs,cols,todo,enough) 
end end end end

-- Returns the leaf clusters, sorted by their median value
-- (so the first leaf is much better than the last leaf).
return function (t,the,cols,      leafs)
  leafs={}
  rdiv(t.rows,0,t,the,leafs,
      cols or t.x,3,
      (#t.rows)^the.enough)
  return discretize(leafs[1], leafs[2],the) end
