local status, luasnip = pcall(require, 'luasnip')
if not status then
    print('luasnip is not installed.')
    return
end

local ls = luasnip
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local fmt = require("luasnip.extras.fmt").fmt
local extras = require("luasnip.extras")
local m = require("luasnip.extras").m
local l = require("luasnip.extras").l
local postfix = require("luasnip.extras.postfix").postfix


ls.snippet = {
  all = {
    s({trig = 'sample'}, {
      t({"Sample Text!"}),
      i(0)
    }),
  }
}

require("luasnip.loaders.from_vscode").lazy_load()
