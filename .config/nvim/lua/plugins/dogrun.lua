return {
    "wadackel/vim-dogrun",
    enabled = false, -- Set to false to disable and re-enable another theme
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd("colorscheme dogrun")
    end,
}
