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

-- B -> beginning of line (like ^)
vim.keymap.set("n", "B", "^", { noremap = true })

-- E -> end of line (like $)
vim.keymap.set("n", "E", "$", { noremap = true })

vim.keymap.set("n", "<leader>q", "<cmd>bdelete<CR>", { desc = "Close current buffer", noremap = true, silent = true })

vim.keymap.set("n", "m", "%", { noremap = true, silent = true })

-- Format JSON with jq
vim.keymap.set("n", "<leader>jq", ":%!jq<CR>", { desc = "Format JSON with jq", noremap = true, silent = true })
vim.keymap.set("v", "<leader>jq", ":!jq<CR>", { desc = "Format selected JSON with jq", noremap = true, silent = true })
