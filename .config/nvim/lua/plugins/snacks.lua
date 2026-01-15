return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            picker = {
                layout = "vscode",
                ui_select = true,
                win = {
                    input = {
                        keys = {
                            ["<Esc>"] = { "close", mode = { "n", "i" } },
                        },
                        border = "rounded",
                        title_pos = "center",
                        -- Fix prompt icon background
                        wo = {
                            winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:PmenuSel",
                        },
                    },
                    list = {
                        border = "rounded",
                        wo = {
                            winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
                        },
                    },
                },
                icons = {
                    prompt = " ", -- Clean prompt icon
                },
                -- Custom highlighting for better visibility
                formatters = {
                    file = {
                        filename_first = true,
                    },
                },
                ignore_patterns = {
                    "node_modules",
                    ".git",
                    "__pycache__",
                    "%.pyc",
                    "dist",
                    "build",
                },
            },
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
            dashboard = {
                enabled = false, -- Disable dashboard
                preset = {
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
                sections = {
                    { section = "header" },
                    { section = "keys", gap = 1, padding = 1 },
                    { section = "startup" },
                },
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
            {
                "<leader>ff",
                function()
                    require("snacks.picker").files()
                end,
                desc = "Find Files in project directory",
            },
            {
                "<leader>gg",
                function()
                    require("snacks.picker").grep()
                end,
                desc = "Find by grepping in project directory",
            },
            {
                "<leader>fb",
                function()
                    require("snacks.picker").buffers()
                end,
                desc = "Find in open buffers",
            },
            {
                "<leader>fh",
                function()
                    require("snacks.picker").help_tags()
                end,
                desc = "Search help tags",
            },
            {
                "<leader>fr",
                function()
                    require("snacks.picker").oldfiles()
                end,
                desc = "Find recent files",
            },
        },
    },
}
