-- vim: ts=2 sw=2 sts=2 et :
-- Tables store rows, summarized in columns.
-- (c) 2021 Tim Menzies (timm@ieee.org) unlicense.org

local Lib  = require("lib")
local Row  = require("row")
local Skip = require("skip")
local Num  = require("num")
local Sym  = require("sym")

local Tbl = Lib.class()

function Tbl:_init(rows) 
  self.rows, self.klass = {},nil
  self.x, self.y,self.all = {},{},{} end

function Tbl:add(t)
  t = t.cells and t.cells or t
  if #self.all>0 then
    self.rows[#self.rows + 1] = self:newRow(t)
  else
    t.all = self:newCols(t) end end

function newRow(t) 
  for _, col in pairs(self.all) do col:add(t[col.at]) end
  return  Row(self,t) end

function Tbl:newCols(t,  what,new) 
  all={}
  for at,txt in pairs(t) do
    what = txt:find("?") and Skip or (
           (txt:sub(1,1):match("%u+") and Num or Sym))
    new  = what(at,txt)
    all[#all+1] = new
    if not txt:find("?") then
      if txt:find("!") then self.klass = new end 
      if   txt:match("[<>!]") then 
           self.y[#self.y+1] = new 
      else self.x[#self.x+1] = new end end end 
  return all end

return Tbl
