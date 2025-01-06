return {
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter", "CmdlineEnter" },
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
		local mappings = require("core.mappings")
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

			mapping = cmp.mapping.preset.insert(mappings.cmp_native(cmp, luasnip)),

			sources = cmp.config.sources({
				{ name = "nvim_lsp", keyword_length = 2 },
				{ name = "luasnip", keyword_length = 2 },
				{ name = "buffer", keyword_length = 2  },
				{ name = "path", keyword_length = 2  },
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
			mapping = cmp.mapping.preset.cmdline(),
			sources = ({
				{ name = "buffer" },
			}),
		})

		cmp.setup.cmdline(':', {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = 'path' },
				{ name = 'cmdline' }
			}),
			matching = { disallow_symbol_nonprefix_matching = false }
		})

	end,
}
