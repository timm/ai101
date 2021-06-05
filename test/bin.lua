-- vim: ts=2 sw=2 sts=2 et :
-- Testing Bins
-- (c) 2021 Tim Menzies (timm@ieee.org) unlicense.org

package.path = '../src/?.lua;' .. package.path 
local r=require
local Lib,Bin,Num=r("lib"),r("bin"),r("num")

do
  local n,xy,num=100,{},Num()
  for i=1,n do 
    num:add(i)
    xy[#xy+1]= {i, i<n/3} end
  local d = num.sd*.3
  local lst = Bin.merge(Bin.div(xy,d, n^.5))
  print("")
  for _,b in pairs(lst) do
    print("::",b.down, b.up) end
  print("d",d)
end

Lib.rogues()
