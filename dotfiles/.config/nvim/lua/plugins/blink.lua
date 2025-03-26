return {
	{
		"saghen/blink.cmp",
		--	event = "nvim-lspconfig",
		opts = {
			keymap = {
				preset = "super-tab",
				["<C-y>"] = { "select_and_accept" },
			},
		},
	},
}
