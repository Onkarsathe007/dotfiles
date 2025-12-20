return {
    enabled = true, -- Set to true to re-enable kanagawa
    "rebelot/kanagawa.nvim",
    priority = 1000,
    config = function()
        require("kanagawa").setup({
            compile = false,
            undercurl = true,
            commentStyle = { italic = true },
            functionStyle = {},
            keywordStyle = { italic = true },
            statementStyle = { bold = true },
            typeStyle = {},
            transparent = true,
            dimInactive = false,
            terminalColors = true,
            colors = {
                palette = {},
                theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
            },
            overrides = function(colors)
                local theme = colors.theme
                return {
                    -- Markdown highlighting
                    ["@markup.link.url.markdown_inline"] = { fg = theme.syn.special1, underline = true },
                    ["@markup.link.label.markdown_inline"] = { fg = theme.syn.identifier, bold = true },
                    ["@markup.italic.markdown_inline"] = { fg = theme.syn.special2, italic = true },
                    ["@markup.raw.markdown_inline"] = { fg = theme.syn.string, bg = theme.ui.bg_p1 },
                    ["@markup.list.markdown"] = { fg = theme.syn.fun },
                    ["@markup.quote.markdown"] = { fg = theme.syn.comment, italic = true },
                    ["@markup.list.checked.markdown"] = { fg = theme.syn.special1, bold = true },
                    ["@markup.heading.1.markdown"] = { fg = theme.syn.special1, bold = true },
                    ["@markup.heading.2.markdown"] = { fg = theme.syn.special2, bold = true },
                    ["@markup.heading.3.markdown"] = { fg = theme.syn.identifier, bold = true },

                    -- Enhanced line numbers
                    LineNr = { fg = theme.ui.nontext },
                    CursorLineNr = { fg = theme.syn.number, bold = true },
                    LineNrAbove = { fg = theme.ui.special },
                    LineNrBelow = { fg = theme.ui.special },

                    -- Better transparency
                    Normal = { bg = "NONE" },
                    NormalFloat = { bg = "NONE" },
                    FloatBorder = { bg = "NONE" },
                    FloatTitle = { bg = "NONE" },
                    SignColumn = { bg = "NONE" },

                    -- Enhanced UI elements
                    Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
                    PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
                    PmenuSbar = { bg = theme.ui.bg_m1 },
                    PmenuThumb = { bg = theme.ui.bg_p2 },

                    -- Better diagnostics
                    DiagnosticVirtualTextError = { bg = "NONE", fg = theme.diag.error },
                    DiagnosticVirtualTextWarn = { bg = "NONE", fg = theme.diag.warning },
                    DiagnosticVirtualTextInfo = { bg = "NONE", fg = theme.diag.info },
                    DiagnosticVirtualTextHint = { bg = "NONE", fg = theme.diag.hint },

                    -- Enhanced telescope
                    TelescopeTitle = { fg = theme.ui.special, bold = true },
                    TelescopePromptNormal = { bg = theme.ui.bg_p1 },
                    TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
                    TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
                    TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
                    TelescopePreviewNormal = { bg = theme.ui.bg_dim },
                    TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },

                    -- Better splits
                    WinSeparator = { fg = theme.ui.bg_p2 },

                    -- Enhanced cursor
                    Cursor = { fg = theme.ui.bg, bg = theme.syn.fun },
                    lCursor = { fg = theme.ui.bg, bg = theme.syn.fun },
                    CursorIM = { fg = theme.ui.bg, bg = theme.syn.fun },
                    TermCursor = { fg = theme.ui.bg, bg = theme.syn.fun },
                    TermCursorNC = { fg = theme.ui.bg, bg = theme.syn.fun },

                    -- Better search highlighting
                    Search = { fg = theme.ui.fg, bg = theme.syn.special1, bold = true },
                    IncSearch = { fg = theme.ui.bg, bg = theme.syn.special2 },
                    CurSearch = { fg = theme.ui.bg, bg = theme.syn.special2 },

                    -- Enhanced git signs
                    GitSignsAdd = { fg = theme.vcs.added },
                    GitSignsChange = { fg = theme.vcs.changed },
                    GitSignsDelete = { fg = theme.vcs.removed },

                    -- Snacks Picker (fzf-like) highlights - Fix folder visibility
                    SnacksPickerDir = { fg = theme.ui.nontext }, -- Faint/dim for directories
                    SnacksPickerFile = { fg = theme.ui.fg, bold = true }, -- Bold for file names
                    SnacksPickerMatch = { fg = theme.syn.special2, bold = true }, -- Highlight matches
                    SnacksPickerPrompt = { fg = theme.syn.fun, bold = true },
                    SnacksPickerBorder = { fg = theme.ui.bg_p2 },
                    SnacksPickerTitle = { fg = theme.ui.special, bold = true },
                    SnacksPickerIcon = { fg = theme.syn.fun }, -- Clean icon color
                    SnacksPickerInput = { fg = theme.ui.fg, bg = "NONE" }, -- Transparent input
                    SnacksPickerCursor = { fg = theme.ui.bg, bg = theme.syn.fun }, -- Visible cursor

                    -- Directory highlighting in general - faint/dim
                    Directory = { fg = theme.ui.nontext }, -- Dim gray, less priority
                }
            end,
            theme = "wave",
            background = {
                dark = "wave",
                light = "lotus",
            },
        })

        vim.cmd("colorscheme kanagawa-wave")

        -- Additional highlight fixes for Snacks picker directories
        vim.api.nvim_create_autocmd("ColorScheme", {
            pattern = "*",
            callback = function()
                local colors = require("kanagawa.colors").setup()
                local theme = colors.theme

                -- Faint/dim directory colors - less priority than file names
                vim.api.nvim_set_hl(0, "Directory", { fg = "#727169" })
                vim.api.nvim_set_hl(0, "SnacksPickerDir", { fg = "#727169" })
                vim.api.nvim_set_hl(0, "SnacksPickerFile", { fg = "#DCD7BA", bold = true })
                vim.api.nvim_set_hl(0, "SnacksPickerMatch", { fg = "#E6C384", bold = true })
                vim.api.nvim_set_hl(0, "SnacksPickerIcon", { fg = "#7E9CD8", bg = "NONE" })
                vim.api.nvim_set_hl(0, "SnacksPickerPrompt", { fg = "#7E9CD8", bg = "NONE" })
                vim.api.nvim_set_hl(0, "SnacksPickerInput", { fg = "#DCD7BA", bg = "NONE" })
                vim.api.nvim_set_hl(0, "SnacksPickerNormal", { bg = "NONE" })
                vim.api.nvim_set_hl(0, "SnacksInput", { fg = "#DCD7BA", bg = "NONE" })
                vim.api.nvim_set_hl(0, "SnacksInputIcon", { fg = "#7E9CD8", bg = "NONE" })
                vim.api.nvim_set_hl(0, "SnacksInputBorder", { fg = "#54546D", bg = "NONE" })
                vim.api.nvim_set_hl(0, "SnacksInputIconPrompt", { fg = "#7E9CD8", bg = "NONE" })
                vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
                vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#54546D", bg = "NONE" })
            end,
        })

        -- Apply immediately
        vim.api.nvim_set_hl(0, "Directory", { fg = "#727169" }) -- Dim gray
        vim.api.nvim_set_hl(0, "SnacksPickerDir", { fg = "#727169" })
        vim.api.nvim_set_hl(0, "SnacksPickerFile", { fg = "#DCD7BA", bold = true })
        vim.api.nvim_set_hl(0, "SnacksPickerMatch", { fg = "#E6C384", bold = true })
        vim.api.nvim_set_hl(0, "SnacksPickerIcon", { fg = "#7E9CD8", bg = "NONE" }) -- Clean icon, no black bg
        vim.api.nvim_set_hl(0, "SnacksPickerPrompt", { fg = "#7E9CD8", bg = "NONE", bold = true })
        vim.api.nvim_set_hl(0, "SnacksPickerInput", { fg = "#DCD7BA", bg = "NONE" }) -- Transparent input
        vim.api.nvim_set_hl(0, "SnacksPickerBorder", { fg = "#54546D" })
        vim.api.nvim_set_hl(0, "SnacksPickerNormal", { bg = "NONE" }) -- Transparent background
        vim.api.nvim_set_hl(0, "SnacksInput", { fg = "#DCD7BA", bg = "NONE" })
        vim.api.nvim_set_hl(0, "SnacksInputIcon", { fg = "#7E9CD8", bg = "NONE" })
        vim.api.nvim_set_hl(0, "SnacksInputBorder", { fg = "#54546D", bg = "NONE" })
        vim.api.nvim_set_hl(0, "SnacksInputTitle", { fg = "#7E9CD8", bg = "NONE" })

        -- Additional fixes for the prompt icon specifically
        vim.api.nvim_set_hl(0, "SnacksInputIconPrompt", { fg = "#7E9CD8", bg = "NONE" })
        vim.api.nvim_set_hl(0, "SnacksNotifierIcon", { fg = "#7E9CD8", bg = "NONE" })

        -- Ensure all float windows have transparent bg
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#54546D", bg = "NONE" })
    end,
}
