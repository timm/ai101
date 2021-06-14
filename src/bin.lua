-- vim: ts=2 sw=2 sts=2 et :
-- # Bin.lua
-- Divide numerics into bins.    
-- (c) 2021 Tim Menzies (timm@ieee.org) unlicense.org
local r=require
local Lib,Thing,Sym = r("lib"),r("thing"),r("sym")
local Bin = Lib.class(Thing)
local merge,div

function Bin:_init(down,up,also) 
  self.down,self.up  = down or -math.huge,  up or math.huge
  self.also = also or Sym() end

function merge(b4,      j,tmp,n,a,b,c)
  j, tmp, n = 1, {}, #b4
  while j<=n do
    a = b4[j]
    if j < n - 1 then
      b = b4[j+1]
      c = a.also:merge(b.also)
      if c then
        a = Bin(a.down,b.up,c)
        j = j+1 end end 
    tmp[#tmp+1] = a
    j = j+1 
  end
  return #tmp==#b4 and tmp or merge(tmp) end

function div(xy, epsilon, width,     now,out,x,y)
  while width<4 and width<#xy/2 do width= 1.2*width end
  table.sort(xy, function(a,b) return a[1] < b[1] end)
  now = Bin(xy[1][1],xy[1][1])
  out = {now}
  for j,one in pairs(xy) do
    x,y = one[1], one[2]
    if j < (#xy - width) then
      if now.also.n >= width then
        if x ~= xy[j+1][1] then
          if now.up - now.down > epsilon then
            now = Bin(x,x)
            out[#out+1] = now end end end end 
    now.up = x
    now.also:add(y) 
  end 
  out = merge(out)
  out[1].down  = -math.huge
  out[#out].up =  math.huge
  return out end

return {bin=Bin,div=div,merge=merge}
