-- vim: ts=2 sw=2 sts=2 et :
-- testing library routines
-- (c) 2021 Tim Menzies (timm@ieee.org) unlicense.org

package.path = '../src/?.lua;' .. package.path 
Lib=require("lib")
local o,isa,rand = Lib.o, Lib.isa, Lib.rand
local rand,seed,round = Lib.rand, Lib.seed, Lib.round
local csv = Lib.csv

do 
  local x= {10,20,{30,{40,50}}}
  local y= Lib.copy(x)
  x[3][2][1]=44444
  assert(y[3][2][1]== 40, "oh dear")
end

do 
  local r,s = Lib.rand, Lib.seed
  s(1)
  local t={}
  local n=100
  for _ = 1,n do t[#t+1] = round(r(),2) end
  s(1)
  for i = 1,n do assert(t[i] == round(r(),2), "oh dear") end
end

do
  local n=0
  for row in csv("data/weather.csv") do 
    n=n+1
    assert(#row == 5," size of rows")
    if  n> 1 then
      assert(type(row[2])=="number","coercion") end end end 

Lib.rogues()
