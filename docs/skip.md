
# Skip.lua
Columns we are going to ignore.   
(c) 2021 Tim Menzies (timm@ieee.org) unlicense.org

```lua

local Lib, Col = require("lib"),require("col")
local Skip=Lib.class(Col)

function Skip:_init(at,txt) self:super(at,txt); self.skip=true; end
function Skip:add(x,_)  return x end

return Skip
```
