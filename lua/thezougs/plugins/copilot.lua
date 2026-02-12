return {
	{
		"github/copilot.vim",
		-- Official GitHub plugin
		lazy = false, -- Recommended not to lazy-load the official plugin for better auth stability
		config = function()
			-- Set Alt-L to accept suggestions (to match your previous config)
			vim.g.copilot_no_tab_map = true
			vim.keymap.set("i", "<M-l>", 'copilot#Accept("\\<CR>")', {
				expr = true,
				replace_keycodes = false,
			})
		end,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "github/copilot.vim" }, -- Dependency updated to official
			{ "nvim-lua/plenary.nvim" },
		},
		build = "make tiktoken",
		opts = {
			-- Auto-pull active buffer context for every question
			selection = function(source)
				return require("CopilotChat.select").buffer(source)
			end,
			window = {
				layout = "float",
				width = 0.4,
				border = "rounded",
				opts = {
					wrap = true,
					linebreak = true,
				},
			},
		},
		keys = {
			{ "<leader>cc", "<cmd>CopilotChatToggle<cr>", desc = "Toggle Copilot Chat" },
			{
				"<leader>cq",
				function()
					local input = vim.fn.input("Quick Chat (Current Buffer): ")
					if input ~= "" then
						require("CopilotChat").ask(input)
					end
				end,
				desc = "Quick Chat with Buffer Context",
			},
		},
	},
}
