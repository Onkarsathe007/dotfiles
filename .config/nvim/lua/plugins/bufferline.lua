return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- important for icons
    config = function()
        require("bufferline").setup({
            options = {
                show_buffer_close_icons = false,
                numbers = "ordinal",
            },
        })

        for i = 1, 9 do
            vim.keymap.set(
                "n",
                "<leader>" .. i,
                string.format("<cmd>BufferLineGoToBuffer %s<CR>", i),
                { noremap = true, silent = true }
            )
        end

        -- BufferLine movement keymaps
        vim.keymap.set(
            "n",
            "<ctrl>h",
            "<cmd>BufferLineMovePrev<CR>",
            { desc = "Move buffer left", noremap = true, silent = true }
        )
        vim.keymap.set(
            "n",
            "<leader>l",
            "<cmd>BufferLineMoveNext<CR>",
            { desc = "Move buffer right", noremap = true, silent = true }
        )

        vim.api.nvim_create_autocmd("ColorScheme", {
            callback = function()
                local highlights = require("bufferline.config").highlights
                for _, def in ipairs(vim.tbl_values(highlights)) do
                    local name = def.hl_group
                    def.hl_group = nil
                    vim.api.nvim_set_hl(0, name, def)
                end
            end,
        })
    end,
}
