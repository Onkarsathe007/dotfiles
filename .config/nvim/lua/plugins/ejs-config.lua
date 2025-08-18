return {
    -- EJS file handling configuration
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            -- Disable treesitter features that might cause formatting issues for EJS
            if opts.indent then
                opts.indent.disable = opts.indent.disable or {}
                table.insert(opts.indent.disable, "ejs")
            end
            return opts
        end,
    },
    
    -- Configure EJS files to prevent automatic formatting
    {
        "stevearc/conform.nvim",
        opts = function(_, opts)
            opts.formatters_by_ft = opts.formatters_by_ft or {}
            -- Explicitly disable all formatters for EJS
            opts.formatters_by_ft.ejs = {}
            
            -- Create a custom formatter that does nothing
            opts.formatters = opts.formatters or {}
            opts.formatters.ejs_noop = {
                command = "cat",
                args = {},
            }
            
            return opts
        end,
    },
}