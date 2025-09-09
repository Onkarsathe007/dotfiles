return {
    -- other plugins
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            indent = { enabled = true, priority = 1, animate = { enabled = false } },
            notifier = { enabled = true, timeout = 3000 },
            -- dashboard = { enabled = true }, -- enabled!
            dashboard = {
                preset = {
                    pick = nil,
                    ---@type snacks.dashboard.Item[]
                    keys = {
                        { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
                        { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                        { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
                        { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
                        { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
                        { icon = " ", key = "s", desc = "Restore Session", section = "session" },
                        { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
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
                -- ...other keybindings...
                {
                    "<leader>st",
                    function()
                        require("snacks").terminal.toggle()
                    end,
                    desc = "Toggle Snacks Terminal",
                },
                -- add more keybindings as in README examples
            },
        },

        -- more plugins...
    }
}
