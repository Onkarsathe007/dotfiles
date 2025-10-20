return {
    "razobeckett/spoclient.nvim",
    name = "spoclient.nvim",
    config = function()
        require("spotify").setup({
            clientId = "cdf07ff3f98e4d19b2c49f14c1d78873",
        })
    end,
    dependencies = {
        "folke/snacks.nvim",
        "nvim-lua/plenary.nvim",
    },
}
