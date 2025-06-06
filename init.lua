local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("general-options")
require("lazy").setup("plugins")

vim.keymap.set("n", "<C-f>", function()
    vim.fn.jobstart({ "tmux", "neww", "tmux-sessionizer" }, { detach = true })
end, { desc = "Open Tmux Sessionizer" })
