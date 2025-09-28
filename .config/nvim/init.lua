require("config.lazy")

-- EJS filetype configuration
vim.filetype.add({
    extension = {
        ejs = "ejs",
    },
})

-- EJS-specific settings to prevent automatic space insertion
vim.api.nvim_create_autocmd("FileType", {
    pattern = "ejs",
    callback = function()
        vim.opt_local.textwidth = 0
        vim.opt_local.formatoptions = "" -- Remove all formatoptions
        vim.opt_local.autoindent = false
        vim.opt_local.smartindent = false
        vim.opt_local.cindent = false
        vim.opt_local.indentexpr = ""
        vim.opt_local.expandtab = true
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
        vim.opt_local.softtabstop = 2
        -- Disable any automatic formatting
        vim.b.autoformat = false
        -- Disable LSP formatting for this buffer
        vim.b.disable_autoformat = true
    end,
})

-- More aggressive prevention of EJS formatting
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.ejs",
    callback = function()
        -- Store cursor position
        local cursor_pos = vim.api.nvim_win_get_cursor(0)
        -- Save without any processing
        vim.cmd("noautocmd write")
        -- Restore cursor position
        vim.api.nvim_win_set_cursor(0, cursor_pos)
        -- Prevent the normal save
        return true
    end,
})

-- Prevent any plugin from modifying EJS files on save
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.ejs",
    callback = function()
        -- Reload the file to ensure no changes were made
        vim.cmd("checktime")
    end,
})
