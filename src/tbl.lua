-- vim: ts=2 sw=2 sts=2 et :
-- Tables store rows, summarized in columns.
-- (c) 2021 Tim Menzies (timm@ieee.org) unlicense.org

local r = require
local Lib,Thing,Row = r("lib"),r("thing"),r("row")
local Skip,Num,Sym  = r("skip"),r("num"),r("sym")

local Tbl = Lib.class()

function Tbl:_init(rows) 
  self.rows, self.klass = {},nil
  self.header={}
  self.x, self.y,self.all = {},{},{} end

-- Create a new table the mimics the current structure
function Tbl:clone(rows)
  new  = Tbl({self.header})
  for row in pairs(rows or {}) do new:add(row)  end
  return new end

-- For first row, make columns; else add a new row
function Tbl:add(t)
  t = t.cells and t.cells or t
  if   #self.all==0 
  then self.all = self:newCols(t) 
  else self.rows[#self.rows+1] = self:newRow(t) end end

-- Update all the columns, return a new row.
function Tbl:newRow(t) 
  for _, col in pairs(self.all) do col:add(t[col.at]) end
  return  Row(self,t) end

function Tbl:newCols(t,  what,new,all,w,x) 
  self.header = t
  all={}
  for at,txt in pairs(t) do
    w= txt:find("?") and Skip or (txt:sub(1,1):match("%u+") and Num or Sym)
    x= w(at,txt)
    all[#all+1] = x
    if not txt:find("?") then
      if   txt:find("!") 
      then self.klass = x 
      end 
      if   txt:match("[<>!]") 
      then self.y[#self.y+1] = x 
      else self.x[#self.x+1] = x end end end 
  return all end

-- Sort neighbors by distance
function Tbl:neighbors(r1,the,cols,rows)
  cols = cols or self.x
  rows = rows or self.rows
  a    = {}
  for _,r2 in pairs(rows) do
    a[#a+1] = {r1:dist(r2,the,cols) -- item1: distance
              , r2} end             -- item2: a row
  table.sort(a, function (y,z) return y[1]<z[1] end)
  return a end

function Tbl:faraway(row,the,cols,rows)
  all = self:around(row,the,cols,rows)
  return all[the.far*all // 1][2] end

return Tbl
