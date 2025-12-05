local keymap = vim.keymap -- for conciseness
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf, silent = true }

    -- set keybinds
    keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
  end,
})

-- vim.lsp.inlay_hint.enable(true)

local severity = vim.diagnostic.severity

vim.diagnostic.config({
  signs = {
    text = {
      [severity.ERROR] = "E",
      [severity.WARN] = "W",
      [severity.HINT] = "H",
      [severity.INFO] = " ",
    },
  },
})
