return {
    "razobeckett/spoclient.nvim",
    name = "spoclient.nvim",
    config = function()
        require("spotify").setup({
            clientId = "97dbfc56e78547459f499fb5ddd398f5",
        })
    end,
    dependencies = {
        "folke/snacks.nvim",
        "nvim-lua/plenary.nvim",
    },
}
