return {
    "baliestri/aura-theme",
    dependencies = {
        "xiyaowong/transparent.nvim",
    },
    lazy = false,
    priority = 1000,
    config = function(plugin)
        -- Load the colorscheme first
        vim.opt.rtp:append(plugin.dir .. "/packages/neovim")
        vim.cmd.colorscheme("aura-dark")

        -- Then enable transparency
        require("transparent").setup({
            exclude_groups = { "CursorLine" },
        })
        vim.cmd("TransparentEnable")
    end,
}
