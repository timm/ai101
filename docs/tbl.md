
# tbl.lua 


Tables store rows, summarized in columns.    
(c) 2021 Tim Menzies (timm@ieee.org) unlicense.org

Tables are initialized from lists whose first item
is a list of column names. In those names,

- anything starting with Upper case is numeric
- anything column  in "?" is to be ignored
- for the non-ignored columns:
- These are held in  `self.all`.
- if there is a klass column (denoted by "!") --     is help in `self.klass`
- Goals to be minimized or maximized are denoted by "-" or "+", respectively.
- Goals are classes are dependent variables and are held in `self.y`.
- All other  columns are independent variables and are held in  `self.x`.

Requires...

```lua
local r = require 
local Lib,Thing,Row = r("lib"),r("thing"),r("row")
local Skip,Num,Sym  = r("skip"),r("num"),r("sym")
```

Create

```lua
local Tbl = Lib.class()

function Tbl:_init(rows) 
  self.rows, self.klass = {},nil
  self.header={}
  self.x, self.y,self.cols = {},{},{} end
```

Create a new table the mimics the current structure

```lua
function Tbl:clone(rows)
  new  = Tbl({self.header})
  for row in pairs(rows or {}) do new:add(row)  end
  return new end
```

For first row, make columns; else add a new row

```lua
function Tbl:add(t)
  t = t.cells and t.cells or t
  if   #self.cols==0 
  then self.cols = self:newCols(t) 
  else self.rows[#self.rows+1] = self:newRow(t) end end
```

Update all the columns, return a new row.

```lua
function Tbl:newRow(t) 
  for _, col in pairs(self.cols) do col:add(t[col.at]) end
  return  Row(self,t) end
```

Initialize the column data.

```lua
function Tbl:newCols(t,  what,new,all,w,x) 
  self.header = t
  all={}
  for at,s in pairs(t) do
    w= s:find("?") and Skip or (s:match("^%u") and Num or Sym)
    x= w(at,s)
    all[#all+1] = x
    if not s:find("?") then -- only if not skipping
      if   s:find("!") 
      then self.klass = x 
      end 
      if   s:match("[%-%+!]") 
      then self.y[#self.y+1] = x 
      else self.x[#self.x+1] = x end end end 
  return all end
```

Sort neighbors by distance

```lua
function Tbl:neighbors(r1,the,cols,rows)
  local a = {}
  for _,r2 in pairs(rows or self.rows) do
    a[#a+1] = {r1:dist(r2,the,cols) -- item1: distance
              , r2} end             -- item2: a row
  table.sort(a, function (y,z) return y[1]<z[1] end)
  return a end
```

Check your neighbors to find  something faraway

```lua
function Tbl:faraway(row,the,cols,rows)
  local all = self:neighbors(row,the,cols,rows)
  return all[the.far*#all // 1][2] end
```

Return

```lua
return Tbl
```

Tables store rows, summarized in columns.    
(c) 2021 Tim Menzies (timm@ieee.org) unlicense.org

Tables are initialized from lists whose first item
is a list of column names. In those names,

- anything starting with Upper case is numeric
- anything column  in "?" is to be ignored
- for the non-ignored columns:
- These are held in  `self.all`.
- if there is a klass column (denoted by "!") --     is help in `self.klass`
- Goals to be minimized or maximized are denoted by "-" or "+", respectively.
- Goals are classes are dependent variables and are held in `self.y`.
- All other  columns are independent variables and are held in  `self.x`.

Requires...

```lua
local r = require 
local Lib,Thing,Row = r("lib"),r("thing"),r("row")
local Skip,Num,Sym  = r("skip"),r("num"),r("sym")
```

Create

```lua
local Tbl = Lib.class()

function Tbl:_init(rows) 
  self.rows, self.klass = {},nil
  self.header={}
  self.x, self.y,self.cols = {},{},{} end
```

Create a new table the mimics the current structure

```lua
function Tbl:clone(rows)
  local new  = Tbl()
  new:add(self.header)
  for _,row in pairs(rows or {}) do new:add(row)  end
  return new end
```

For first row, make columns; else add a new row

```lua
function Tbl:add(t)
  t = t.cells and t.cells or t
  if   #self.cols==0 
  then self.cols = self:newCols(t) 
  else self.rows[#self.rows+1] = self:newRow(t) end end
```

Update all the columns, return a new row.

```lua
function Tbl:newRow(t) 
  for _, col in pairs(self.cols) do col:add(t[col.at]) end
  return  Row(self,t) end
```

Initialize the column data.

```lua
function Tbl:newCols(t,  what,new,all,w,x) 
  self.header = t
  all={}
  for at,s in pairs(t) do
    w= s:find("?") and Skip or (s:match("^%u") and Num or Sym)
    x= w(at,s)
    all[#all+1] = x
    if not s:find("?") then -- only if not skipping
      if   s:find("!") 
      then self.klass = x 
      end 
      if   s:match("[%-%+!]") 
      then self.y[#self.y+1] = x 
      else self.x[#self.x+1] = x end end end 
  return all end

function Tbl:goals() 
  local out={}
  for _,col in pairs(self.y) do out[#out+1] = col:mid() end
  return out
end

function Tbl:mid() 
  local out={}
  for _,col in pairs(self.cols) do out[#out+1] = col:mid() end
  return out
end
```

Sort neighbors by distance

```lua
function Tbl:neighbors(r1,the,cols,rows)
  local a = {}
  for _,r2 in pairs(rows or self.rows) do
    a[#a+1] = {r1:dist(r2,the,cols) -- item1: distance
              ,r2} end              -- item2: a row
  table.sort(a, function (y,z) return y[1]<z[1] end)
  return a end
```

Check your neighbors to find  something faraway

```lua
function Tbl:faraway(row,the,cols,rows)
  local all = self:neighbors(row,the,cols,rows)
  return all[the.far*#all // 1][2] end
```

Return

```lua
return Tbl
```

Tables store rows, summarized in columns.    
(c) 2021 Tim Menzies (timm@ieee.org) unlicense.org

# Tbl.lua

Tables are initialized from lists whose first item
is a list of column names. In those names,

- anything starting with Upper case is numeric
- anything column  in "?" is to be ignored
- for the non-ignored columns:
- These are held in  `self.all`.
- if there is a klass column (denoted by "!") --     is help in `self.klass`
- Goals to be minimized or maximized are denoted by "-" or "+", respectively.
- Goals are classes are dependent variables and are held in `self.y`.
- All other  columns are independent variables and are held in  `self.x`.

Requires...

```lua
local r = require 
local Lib,Thing,Row = r("lib"),r("thing"),r("row")
local Skip,Num,Sym  = r("skip"),r("num"),r("sym")
```

Create

```lua
local Tbl = Lib.class()

function Tbl:_init(rows) 
  self.rows, self.klass = {},nil
  self.header={}
  self.x, self.y,self.cols = {},{},{} end
```

Create a new table the mimics the current structure

```lua
function Tbl:clone(rows)
  local new  = Tbl()
  new:add(self.header)
  for _,row in pairs(rows or {}) do new:add(row)  end
  return new end
```

For first row, make columns; else add a new row

```lua
function Tbl:add(t)
  t = t.cells and t.cells or t
  if   #self.cols==0 
  then self.cols = self:newCols(t) 
  else self.rows[#self.rows+1] = self:newRow(t) end end
```

Update all the columns, return a new row.

```lua
function Tbl:newRow(t) 
  for _, col in pairs(self.cols) do col:add(t[col.at]) end
  return  Row(self,t) end
```

Initialize the column data.

```lua
function Tbl:newCols(t,  what,new,all,w,x) 
  self.header = t
  all={}
  for at,s in pairs(t) do
    w= s:find("?") and Skip or (s:match("^%u") and Num or Sym)
    x= w(at,s)
    all[#all+1] = x
    if not s:find("?") then -- only if not skipping
      if   s:find("!") 
      then self.klass = x 
      end 
      if   s:match("[%-%+!]") 
      then self.y[#self.y+1] = x 
      else self.x[#self.x+1] = x end end end 
  return all end

function Tbl:goals() 
  local out={}
  for _,col in pairs(self.y) do out[#out+1] = col:mid() end
  return out
end

function Tbl:mid() 
  local out={}
  for _,col in pairs(self.cols) do out[#out+1] = col:mid() end
  return out
end
```

Sort neighbors by distance

```lua
function Tbl:neighbors(r1,the,cols,rows)
  local a = {}
  for _,r2 in pairs(rows or self.rows) do
    a[#a+1] = {r1:dist(r2,the,cols) -- item1: distance
              ,r2} end              -- item2: a row
  table.sort(a, function (y,z) return y[1]<z[1] end)
  return a end
```

Check your neighbors to find  something faraway

```lua
function Tbl:faraway(row,the,cols,rows)
  local all = self:neighbors(row,the,cols,rows)
  return all[the.far*#all // 1][2] end
```

Return

```lua
return Tbl
```
