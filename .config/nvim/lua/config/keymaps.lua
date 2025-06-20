vim.keymap.set("n", "-", "<cmd>Oil --float<CR>", { desc = "Open Parent Directory in Oil" })
vim.keymap.set("n", "<esc><esc>", "<cmd>nohl<CR>", { desc = "Clear Highlight" })
vim.keymap.set("n", "gl", function()
    vim.diagnostic.open_float()
end, { desc = "Open Diagnostics in Float" })

vim.keymap.set("n", "<leader>db", function()
    require("snacks").background()
end, { desc = "Go to Snacks background" })

vim.keymap.set("n", "<leader>cf", function()
    require("conform").format({
        lsp_format = "fallback",
    })
end, { desc = "Format current file" })

vim.keymap.set("n", "<leader>q", "<cmd>bdelete<CR>", { desc = "Close current buffer", noremap = true, silent = true })
