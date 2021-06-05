-- vim: ts=2 sw=2 sts=2 et :
-- # About.lua
-- Defaults, maybe updated via command-line
-- (c) 2021 Tim Menzies (timm@ieee.org) unlicense.org

return require("lib").cli({
   enough=.5
  ,far=.9
  ,loud=true
  ,cohen=.3
  ,k=2
  ,m=1
  ,p=2
  ,data="data/aa.csv"
  ,seed=10013
})
