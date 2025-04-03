-- set leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- split the screen
vim.keymap.set("n", "<leader>i", ":split<CR>")
vim.keymap.set("n", "<leader>o", ":vsplit<CR>")
-- leave the file and return to the directory.
vim.keymap.set("n", "<leader>ex", vim.cmd.Ex)
-- format the current file.
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
-- moves what is selected up or down. will also indent.
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- centers when moving up and down using ctrl-u/d.
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- copy to clipboard.
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
-- the above needs this when on wsl2
-- if vim.fn.has("wsl") == 1 then
--     if vim.fn.executable("wl-copy") == 0 then
--         print("wl-clipboard not found, clipboard integration won't work")
--     else
--         vim.g.clipboard = {
--             name = "wl-clipboard (wsl)",
--             copy = {
--                 ["+"] = 'wl-copy --foreground --type text/plain',
--                 ["*"] = 'wl-copy --foreground --primary --type text/plain',
--             },
--             paste = {
--                 ["+"] = (function()
--                     return vim.fn.systemlist('wl-paste --no-newline|sed -e "s/\r$//"', { '' }, 1) -- '1' keeps empty lines
--                 end),
--                 ["*"] = (function()
--                     return vim.fn.systemlist('wl-paste --primary --no-newline|sed -e "s/\r$//"',
--                         { '' }, 1)
--                 end),
--             },
--             cache_enabled = true
--         }
--     end
-- end

-- toggle the left side bar; yes, no, auto
vim.cmd("set scl=yes") -- on for gitsigns

-- remove tabs/ fix spacing
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")

vim.o.nu = true
vim.o.relativenumber = true
vim.o.hlsearch = false
vim.opt.termguicolors = true

-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
})

-- Neogit here to avoid config problems
vim.keymap.set("n", "<leader>ng", ":Neogit<CR>", {})
