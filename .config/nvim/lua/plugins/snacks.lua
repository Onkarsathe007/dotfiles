return {
    -- other plugins
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            indent = { enabled = true, priority = 1, animate = { enabled = true } },
            notifier = { enabled = true, timeout = 3000 },
            scroll = { enabled = true, animate = { duration = { step = 15, total = 150 } } },
            words = { enabled = true },
            git = { enabled = true },
            lazygit = { enabled = true },
            rename = { enabled = true },
            scratch = { enabled = true },
            zen = {
                enabled = true,
                width = 140,
                height = 0.9,
                backdrop = { transparent = true },
            },
            -- dashboard = { enabled = true }, -- enabled!
            dashboard = {
                preset = {
                    pick = nil,
                    ---@type snacks.dashboard.Item[]
                    keys = {
                        {
                            icon = " ",
                            key = "f",
                            desc = "Find File",
                            action = ":lua Snacks.dashboard.pick('files')",
                        },
                        { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                        {
                            icon = " ",
                            key = "g",
                            desc = "Find Text",
                            action = ":lua Snacks.dashboard.pick('live_grep')",
                        },
                        {
                            icon = " ",
                            key = "r",
                            desc = "Recent Files",
                            action = ":lua Snacks.dashboard.pick('oldfiles')",
                        },
                        {
                            icon = " ",
                            key = "c",
                            desc = "Config",
                            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
                        },
                        { icon = " ", key = "s", desc = "Restore Session", section = "session" },
                        {
                            icon = "󰒲 ",
                            key = "l",
                            desc = "Lazy",
                            action = ":Lazy",
                            enabled = package.loaded.lazy ~= nil,
                        },
                        { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                    },
                    header = [[
                                                                             
               ████ ██████           █████      ██                     
              ███████████             █████                             
              █████████ ███████████████████ ███   ███████████   
             █████████  ███    █████████████ █████ ██████████████   
            █████████ ██████████ █████████ █████ █████ ████ █████   
          ███████████ ███    ███ █████████ █████ █████ ████ █████  
         ██████  █████████████████████ ████ █████ █████ ████ ██████ 
      ]],
                },
                explorer = { enabled = false },
                terminal = { enabled = true },
                tweaks = { enabled = true }, -- Enable tweaks!
                background = {
                    enabled = true,
                    image = "~/Pictures/wallpapers/aesthetic2.jpg",
                    opacity = 1,
                    stretch = "fit",
                },
                -- ...add more as you like
            },
        },
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
            {
                "<leader>0",
                function()
                    require("snacks").dashboard()
                end,
                desc = "Open Snacks Dashboard",
            },
            {
                "<leader>st",
                function()
                    require("snacks").terminal.toggle()
                end,
                desc = "Toggle Snacks Terminal",
            },
            {
                "<leader>z",
                function()
                    require("snacks").zen()
                end,
                desc = "Toggle Zen Mode",
            },
            {
                "<leader>.",
                function()
                    require("snacks").scratch()
                end,
                desc = "Toggle Scratch Buffer",
            },
            {
                "<leader>S",
                function()
                    require("snacks").scratch.select()
                end,
                desc = "Select Scratch Buffer",
            },
            {
                "<leader>gB",
                function()
                    require("snacks").gitbrowse()
                end,
                desc = "Git Browse",
                mode = { "n", "v" },
            },
            {
                "<leader>gf",
                function()
                    require("snacks").lazygit.log_file()
                end,
                desc = "Lazygit Current File History",
            },
            {
                "<leader>cR",
                function()
                    require("snacks").rename.rename_file()
                end,
                desc = "Rename File",
            },
        },

        -- more plugins...
    },
}
