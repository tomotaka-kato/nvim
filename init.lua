-- 使用していない remote provider の検出を無効化する
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

require 'base'
require 'maps'

-- プラグイン設定
require 'lazy_nvim'
