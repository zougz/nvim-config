return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				cpp = { "bdi_formatter" },
				c = { "bdi_formatter" },
				python = { "bdi_formatter" },
				typescript = { "bdi_formatter" },
				javascript = { "bdi_formatter" },
				lua = { "bdi_formatter" },
				bazel = { "bdi_formatter" },
				bzl = { "bdi_formatter" },
			},
			formatters = {
				bdi_formatter = {
					-- Point directly to the compiled bazel-bin executable (Fastest)
					-- command = vim.fn.expand(""),
					args = { "$FILENAME" },
					stdin = false,
				},
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 2000,
			},
		})

		-- Optional keymap to trigger formatting manually
		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 2000,
			})
		end, { desc = "Format file or range" })
	end,
}
