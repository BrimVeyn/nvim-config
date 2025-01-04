return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*",
			build = "make install_jsregexp",
		},
		"saadparwaiz1/cmp_luasnip",
		"rafamadriz/friendly-snippets",
		"onsails/lspkind.nvim",
		'windwp/nvim-autopairs',
	},
	config = function()
		local cmp = require("cmp")

		local luasnip = require("luasnip")

		local lspkind = require("lspkind")

		local cmp_autopairs = require('nvim-autopairs.completion.cmp')

		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.event:on(
			'confirm_done',
			cmp_autopairs.on_confirm_done()
		)

		cmp.setup({
			completion = {
				completeopt = "menu,menuone,preview,noselect",
			},

			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},

			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},

			mapping = cmp.mapping.preset.insert({
				["<Tab>"]	= cmp.mapping.select_next_item(), -- Previous suggestion
				["<S-Tab>"] = cmp.mapping.select_prev_item(), -- Next suggestion
				["<CR>"]	= cmp.mapping.confirm({ select = false }),  -- Confirm
				["<C-e>"]	= cmp.mapping.abort(), -- Close
				["<C-b>"]	= cmp.mapping.scroll_docs(-4), -- Move docs up
				["<C-f>"]	= cmp.mapping.scroll_docs(4), -- Move docs down
			}),

			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "path" },
			}),

			formatting = {
				format = lspkind.cmp_format({
					maxwidth = 50,
					ellipsis_char = "...",
				}),
				expandable_indicator = true,
			},

		})

		cmp.setup.cmdline('/', {
			view = {
				entries = {name = 'wildmenu', separator = '|' }
			},
			-- For some reason mapping attriubute doesn't work here so we setup the keybindings manually

			sources = ({
				{ name = "buffer" },
			}),
		})

		vim.keymap.set("c", "<Tab>", cmp.mapping.select_next_item(), {})
		vim.keymap.set("c", "<S-Tab>", cmp.mapping.select_prev_item(), {})

	end,
}
