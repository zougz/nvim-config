return {
	"greggh/claude-code.nvim",
	event = "BufReadPost",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	keys = {
		{ "<leader>aa", "<cmd>ClaudeCode<cr>", desc = "Claude: Toggle Chat" },
	},
	opts = {
		window = {
			split_side = "right",
		},
	},
}
