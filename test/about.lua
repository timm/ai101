-- vim: ts=2 sw=2 sts=2 et :
-- testing library routines
-- (c) 2021 Tim Menzies (timm@ieee.org) unlicense.org

package.path = '../src/?.lua;' .. package.path 
Lib=require("lib")

local the=require("about")
assert(the.m == 1,"config")
Lib.rogues()
