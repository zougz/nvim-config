return {
  'tpope/vim-fugitive',
  name = 'fugitive',
  lazy = true,
  
  -- The plugin will be loaded when any of these commands or keys are used
  cmd = { 'Git', 'Gdiff', 'Gedit', 'Gstatus', 'Gblame', 'Glog', 'Gcommit' },
  keys = {
    -- This keymap will also trigger the lazy-load
    { '<leader>gs', mode = 'n', desc = 'Git Status (Fugitive)' }, 
  },
  
  config = function()
    -- 1. Standard Mapping to open :Git status window
    vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Git Status" })
    
    -- 2. Autocmd Group for Fugitive-specific Mappings (TheZougs's setup)
    local TheZougs_Fugitive = vim.api.nvim_create_augroup("TheZougs_Fugitive", { clear = true })

    vim.api.nvim_create_autocmd("BufWinEnter", {
      group = TheZougs_Fugitive,
      pattern = "*",
      callback = function()
        -- Only apply mappings when the filetype is 'fugitive' (i.e., in the :Git status window)
        if vim.bo.ft ~= "fugitive" then
          return
        end

        local bufnr = vim.api.nvim_get_current_buf()
        local opts = { buffer = bufnr, remap = false }

        -- <leader>p: Simple push
        vim.keymap.set("n", "<leader>p", function()
          vim.cmd.Git('push')
        end, opts)

        -- <leader>P: Pull with rebase
        vim.keymap.set("n", "<leader>P", function()
          vim.cmd.Git({'pull',  '--rebase'})
        end, opts)

        -- <leader>t: Push to set upstream (Note: The original mapping was incorrect for a function, 
        -- so I converted it to a standard command mapping for the terminal view)
        vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts);
      end,
    })
  end,
}
