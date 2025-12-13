return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons", -- optional, for file icons
	},
	config = function()
		-- Disable netrw at the very start of your init.lua (recommended by nvim-tree)
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		require("nvim-tree").setup({
			sort = {
				sorter = "case_sensitive",
			},
			view = {
				width = 35,
				side = "left",
			},
			renderer = {
				group_empty = true,
				icons = {
					show = {
						git = true,
						folder = true,
						file = true,
						folder_arrow = true,
					},
				},
			},
			filters = {
				dotfiles = false, -- Show hidden files by default
			},
			git = {
				enable = true,
				ignore = false,
			},
			actions = {
				open_file = {
					quit_on_open = false,
					window_picker = {
						enable = true,
					},
				},
			},
		})

		-- Easy keymaps for nvim-tree
		-- <leader>t - Toggle tree (most common)
		vim.keymap.set("n", "<leader>t", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file tree", noremap = true, silent = true })
		
		-- <leader>tf - Find current file in tree
		vim.keymap.set("n", "<leader>tf", "<cmd>NvimTreeFindFile<CR>", { desc = "Find file in tree", noremap = true, silent = true })
		
		-- <leader>tc - Collapse all folders in tree
		vim.keymap.set("n", "<leader>tc", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse tree folders", noremap = true, silent = true })
		
		-- <leader>tr - Refresh tree
		vim.keymap.set("n", "<leader>tr", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh tree", noremap = true, silent = true })
	end,
}
