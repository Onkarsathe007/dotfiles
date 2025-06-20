return {
    -- other plugins
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            -- Enable desired sub‑plugins; enabling “notifier” is enough for snacky notifications
            notifier = { enabled = true, timeout = 3000 },
            -- Optionally enable more, like dashboard, picker, terminal, etc.
            dashboard = { enabled = false },
            explorer = { enabled = false },
            -- ...add more as you like
        },
        -- optional: load keys for features like explorer, terminal, toggles
        keys = {
            {
                "<leader>lg",
                function()
                    Snacks.lazygit()
                end,
                desc = "Open LazyGit",
            },
            {
                "<leader><space>",
                function()
                    Snacks.picker.smart()
                end,
                desc = "Smart picker",
            },
            -- add more keybindings as in README examples
        },
    },

    -- more plugins...
}
