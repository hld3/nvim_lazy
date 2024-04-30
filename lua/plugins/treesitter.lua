return { 
    "nvim-treesitter/nvim-treesitter", build = ":TSUpdate",
    config = function()
        local treeconfig = require("nvim-treesitter.configs")
        treeconfig.setup({
            ensure_installed = { "go", "lua", "java" },
            highlight = { enable = true },
            indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = "<C-s>",
                    node_decremental = "<M-space>",
                },
            },
        })
    end
}
