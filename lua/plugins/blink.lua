return {
	"saghen/blink.cmp",
	version = "1.*",
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*",
			build = "make install_jsregexp",
		},
		"onsails/lspkind.nvim",
		'echasnovski/mini.icons',
		"rafamadriz/friendly-snippets",
		'windwp/nvim-autopairs',
		"xzbdmw/colorful-menu.nvim",
	},
	opts = {
		keymap = {
			['<Tab>'] = { 'select_next', 'fallback' },
			['<S-Tab>'] = { 'select_prev', 'fallback' },
			['<C-n>'] = { 'select_next', 'show' },
			['<C-p>'] = { 'select_prev', 'show' },
			['<C-e>'] = { 'hide', 'fallback' },
			['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
			['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
			['<CR>'] = { 'accept', 'fallback' },
		},

		completion = {
			menu = {
				border = 'rounded',
				draw = {
					-- We don't need label_description now because label and label_description are already
					-- combined together in label by colorful-menu.nvim.
					columns = { { "kind_icon" }, { "label", gap = 1 }, { "kind" } },
					components = {
						label = {
							text = function(ctx)
								return require("colorful-menu").blink_components_text(ctx)
							end,
							highlight = function(ctx)
								return require("colorful-menu").blink_components_highlight(ctx)
							end,
						},
					},
				}
			},
			documentation = {
				window = { border = 'rounded' },
				auto_show = true,
				auto_show_delay_ms = 100,
			},
			list = {
				selection = {
					preselect = false,
				}
			},
			ghost_text = { enabled = true },
			auto_brackets = { enabled = true },
		},

		signature = {
			enabled = true,
			window = {
				show_documentation = false,
			},
		},


		snippets = { preset = 'luasnip' },

		sources = {
			default = { 'lsp', 'path', 'snippets', 'buffer' },
		},

		cmdline = {
			keymap = { preset = 'cmdline' },
			completion = { menu = { auto_show = true } },
		},
	},
	config = function(_, opts)
		require("luasnip.loaders.from_vscode").lazy_load()
		require('blink.cmp').setup(opts)
	end,
}
