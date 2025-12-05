return {
  'mbbill/undotree',
  name = 'undotree',
  lazy = true, -- Enable lazy loading

  -- The plugin will be loaded only when the command or keymap is used
  cmd = { 'UndotreeToggle', 'UndotreeFocus' },
  keys = {
    -- This keymap will trigger the lazy-load
    { '<leader>u', mode = 'n', desc = 'Toggle Undotree' },
  },

  config = function()
    vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle Undotree" })

    vim.g.undotree_WindowLayout = 2 -- Moves the window to the left sidebar (default is bottom)
    vim.g.undotree_SetFocusWhenToggle = 1 -- Focuses the undotree window when toggled open
    vim.g.undotree_ShortIndicators = 1 -- Use shorter indicators in the main window
  end,
}
