-- Show line numbers
vim.wo.nu = true
-- Disable netrw for nvim-tree plugin
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
local keyopts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
local uv = vim.uv or vim.loop

-- Auto-install lazy.nvim if not present
if not uv.fs_stat(lazypath) then
	print('Installing lazy.nvim....')
	vim.fn.system({
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable', -- latest stable release
		lazypath,
	})
	print('Done.')
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup('fenn.plugins')

-- Themes
vim.opt.termguicolors = true
vim.cmd.colorscheme('tokyonight')

-- vim.cmd.colorscheme('morning')
-- Webicons
require('nvim-web-devicons').setup({})

-- LSP
local lsp_zero = require('lsp-zero')
lsp_zero.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	lsp_zero.default_keymaps({ buffer = bufnr })
end)
require('mason').setup({})
require('mason-lspconfig').setup({
	handlers = {
		function(server_name)
			require('lspconfig')[server_name].setup({})
		end,
	},
	ensure_installed = { "lua_ls", "rust_analyzer", "jdtls" }
})

-- Autocompletion
local cmp = require('cmp')
local cmp_action = lsp_zero.cmp_action()

cmp.setup({
	mapping = cmp.mapping.preset.insert({
		-- `TAB` key to confirm completion
		['<Tab>'] = cmp.mapping.confirm({ select = false }),

		-- Ctrl+Space to trigger completion menu
		['<C-Space>'] = cmp.mapping.complete(),

		-- Navigate between snippet placeholder
		['<C-f>'] = cmp_action.luasnip_jump_forward(),
		['<C-b>'] = cmp_action.luasnip_jump_backward(),

		-- Scroll up and down in the completion documentation
		['<C-u>'] = cmp.mapping.scroll_docs(-4),
		['<C-d>'] = cmp.mapping.scroll_docs(4),
	}),
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
})

-- Telescope
local telescope = require('telescope')
telescope.setup({})
keymap("n", "<CS-t>", ":Telescope find_files<CR>", keyopts)

-- Nvim Tree
require("nvim-tree").setup({
	on_attach = function(bufnr)
		local api = require('nvim-tree.api')
		local function opts(desc)
			return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
		end
		api.config.mappings.default_on_attach(bufnr)
		vim.keymap.set('n', '<C-e>', "<C-w><C-p>", opts('Unfocus'))
	end
})
keymap("n", "<C-e>", ":NvimTreeFindFile<CR>", keyopts)
