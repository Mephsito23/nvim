local map = vim.api.nvim_set_keymap
-- 复用 opt 参数
local opt = {
    noremap = true,
    silent = true
}

-- 在普通模式下，把 Ctrl-[ 映射为返回上一个位置
vim.keymap.set('n', '<C-[>', '<C-T>', opt)

map('n', '<A-m>', ':NvimTreeToggle<CR>', opt)

map("n", "<C-h>", ":BufferLineCyclePrev<CR>", opt)
map("n", "<C-l>", ":BufferLineCycleNext<CR>", opt)

-- keybindings.lua
local pluginKeyBinding = {}
return pluginKeyBinding

