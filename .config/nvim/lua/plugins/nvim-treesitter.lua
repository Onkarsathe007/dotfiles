return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = {
                "c",
                "lua",
                "vim",
                "vimdoc",
                "query",
                "elixir",
                "heex",
                "javascript",
                "html",
                "markdown",
                "markdown_inline",
                "embedded_template",
            },
            auto_install = true,
            sync_install = false,
            highlight = { enable = true },
            indent = {
                enable = true,
                disable = { "ejs" }, -- Disable treesitter indent for EJS files
            },

            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "gnn", -- Changed from <Enter> to avoid auto-selection
                    node_incremental = "grn",
                    scope_incremental = "grc",
                    node_decremental = "grm",
                },
            },
        })
    end,
}
