return {
    "baliestri/aura-theme",
    dependencies = {
        --- for trnasparent background
        "xiyaowong/transparent.nvim",
    },
    lazy = false,
    priority = 1000,
    config = function(plugin)
        require("transparent").setup({
            exclude_groups = { "CursorLine" },
        })
        vim.opt.rtp:append(plugin.dir .. "/packages/neovim")
        vim.cmd.colorscheme("aura-dark")
    end,
}
