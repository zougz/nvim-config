return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	config = function()
		local bdi_path = vim.env.BDI

		if not bdi_path then
			vim.schedule(function()
				vim.notify(
					"ERROR: $BDI environment variable is not set. clang_format will likely fail.",
					vim.log.levels.ERROR
				)
			end)
			return
		end

		local style_path = "-style=file:" .. bdi_path .. "/rt/.clang-format"

		require("conform").setup({
			format_on_save = {
				timheout_ms = 500,
				lsp_fallback = true,
			},
			formatters_by_ft = {
				cpp = { "clang_format" },
				c = { "clang_format" },
			},
			formatters = {
				clang_format = {
					args = {
						style_path,
					},
				},
			},
		})
	end,
}
