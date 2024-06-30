-- Fuzzy finder
return {
	{ "junegunn/fzf", build = "./install --bin" },
	{
		"ibhagwan/fzf-lua",
		-- optional for icon support
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			-- calling `setup` is optional for customization
			require("fzf-lua").setup({})
		end
	},
	{'nvim-lua/plenary.nvim'},
	{'BurntSushi/ripgrep'},
	{'nvim-telescope/telescope.nvim'},
}
