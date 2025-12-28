-- 在普通模式下，把 Ctrl-[ 映射为返回上一个位置
vim.keymap.set('n', '<C-[>', '<C-T>', {
    noremap = true,
    silent = true
})
