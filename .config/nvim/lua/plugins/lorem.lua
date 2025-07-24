return {
    "derektata/lorem.nvim",
    lazy = false, -- load immediately
    config = function()
        -- Set optional customization (defaults are sensible)
        require("lorem").opts({
            sentence_length = "mixed", -- mixed lengths
            comma_chance = 0.3,
            max_commas = 2,
            debounce_ms = 200,
        })

        -- Optional: keymaps for quick insertion
        vim.keymap.set(
            "n",
            "<leader>ll",
            ":LoremIpsum paragraphs 1<CR>",
            { desc = "🧩 Insert Lorem Ipsum Paragraphs" }
        )
        vim.keymap.set(
            "v",
            "<leader>ll",
            ":LoremIpsum paragraphs 1<CR>",
            { desc = "🧩 Replace selection with Lorem Ipsum" }
        )
    end,
}
