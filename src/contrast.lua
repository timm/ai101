-- vim: ts=2 sw=2 sts=2 et :
-- # Rcontrast.lua
-- Recursively prune data using  min maximal delta between halves.  
-- (c) 2021 Tim Menzies (timm@ieee.org) unlicense.org

local r = require
local Lib,Thing,Tbl = r("lib"),r("thing"),r("tbl")

 local function discretize(lefts,rights,the)
    local counts={}
    for n,left in pairs(lefts.x) do
      local right = rights.x[n]
      left:discretize(right,counts,the)
    end
    for _,counts1 in pairs(counts) do table.sort(counts1) end
    return counts
  end

local function rank(bests, rests, counts,     rest,r,b)
    local ranks={}
    for _,best in pairs(counts[true]) do
      rest = best:other(counts) 
      r = (rest and rest.n or 0)/rests
      b = best.n/bests
      if b>r then
        ranks[1+#ranks] = {b^2/(b+r), best} end end
    table.sort(ranks, function (x,y) return x[1] > y[1] end)
    --for _,x in pairs(ranks) do print(x[1],tostring(x[2])) end
    return ranks
end

local function contrast(t,the,cols)
  ---- set defaults
  cols = cols or t.x
  local all    = {}
  local enough = (#t.rows)^the.enough
  local function divide(t1,lvl)
    -- debugging
    if   the.loud 
    then local pre="|.. ";print(pre:rep(lvl)..tostring(#t1.rows)) end
    -- termination case
    if   #t1.rows < 2*enough 
    then all[#all+1] = t1
         return
    end
    -- recursive case
    local zero,one,two,c,a,b, mid,left,right,lefts,rights
    zero = Lib.any(t1.rows)
    one  = t:faraway(zero, the, cols, t1.rows)
    two  = t:faraway(one,  the, cols, t1.rows)
    c    = one:dist(two, the, cols)
    for _,row in pairs(t1.rows) do
      a  = row:dist(one, the, cols)
      b  = row:dist(two, the, cols)
      row.x = (a^2 + c^2 - b^2)/(2*c) 
    end
    table.sort(t1.rows, function(y,z) return y.x < z.x end)
    mid, left, right = #t1.rows//2, {}, {}
    lefts,rights = t:clone(), t:clone()
    for n,row in pairs(t1.rows) do
      if   n <= mid 
      then lefts:add(row)
      else rights:add(row) 
      end  
    end
    return lefts,rights
  end 
  local function recurse(t1,lvl,     l,r,best,t2)
    if #t1.rows > 2*enough then
      l,r = divide(t1,lvl)
      best= rank(#l.rows, #r.rows, 
                 discretize(l,r,the))[1][2]
      t2 = t1:clone(best:selects(t1.rows))
      print(tostring(best))
      Lib.o(t2:goals())
      if #t2.rows < #t1.rows then recurse(t2, lvl+1) end end
  end
    
  --- main -------------
  Lib.o(t:goals())
  recurse(t,0)
end 

return  contrast
