-- vim: ts=2 sw=2 sts=2 et :
-- Columns we are going to ignore
-- (c) 2021 Tim Menzies (timm@ieee.org) unlicense.org

local Lib, Col = require("lib"),require("col")
local Skip=Lib.class(Col)

function Skip:_init(at,txt) self:super(at,txt) end
function Skip:add(x,_)  return x end

return Skip
