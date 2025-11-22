return {
	"rmagatti/auto-session",
	lazy = false,
	--enables autocomplete for opts
	--@module "auto-session"
	--@type AutoSession.Config
	opts = { suppressed_dirs = { '~/', '/' }, },
	-- NOTE: autoSession provides default keys for telescope but we use snacks
	-- see snacks config
}
