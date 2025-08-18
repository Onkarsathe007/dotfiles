-- EJS-safe save and quit commands
vim.api.nvim_create_user_command("EjsSave", function()
    if vim.bo.filetype == "ejs" then
        vim.cmd("noautocmd write")
    else
        vim.cmd("write")
    end
end, { desc = "Save EJS file without formatting" })

vim.api.nvim_create_user_command("EjsWq", function()
    if vim.bo.filetype == "ejs" then
        vim.cmd("noautocmd write")
        vim.cmd("quit")
    else
        vim.cmd("wq")
    end
end, { desc = "Save and quit EJS file without formatting" })

-- Map common save commands for EJS files
vim.api.nvim_create_autocmd("FileType", {
    pattern = "ejs",
    callback = function()
        -- Override :w and :wq for EJS files
        vim.keymap.set("c", "w<CR>", "EjsSave<CR>", { buffer = true, remap = true })
        vim.keymap.set("c", "wq<CR>", "EjsWq<CR>", { buffer = true, remap = true })
    end,
})

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
