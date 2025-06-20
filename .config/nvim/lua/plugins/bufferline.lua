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
