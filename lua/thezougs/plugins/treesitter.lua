return {
  'nvim-treesitter/nvim-treesitter',
  
  -- The 'build' step is necessary for Treesitter to work.
  build = ':TSUpdate',

  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  
  config = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = {"vim", "c", "lua", "rust", "groovy", "python", "javascript", "typescript", "html", "css", "json"},
      
      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

      -- Automatically install missing parsers when entering buffer
      auto_install = true,

      highlight = {
        -- `false` will disable the whole extension
        enable = true,
        additional_vim_regex_highlighting = false,
      },

      -- Configuration for `nvim-treesitter-textobjects`
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            -- Text objects for function calls/definitions, classes, loops, etc.
            -- e.g., 'af' (around function), 'if' (inside function)
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- Re-use vim's jump list
          goto_next_start = {
            [']m'] = '@function.outer',
            [']]'] = '@class.outer',
          },
          goto_next_end = {
            [']M'] = '@function.outer',
            [']['] = '@class.outer',
          },
          goto_previous_start = {
            ['[m'] = '@function.outer',
            ['[['] = '@class.outer',
          },
          goto_previous_end = {
            ['[M'] = '@function.outer',
            ['[]'] = '@class.outer',
          },
        },
      },
      
      indent = { enable = true },
    }
    
    if #vim.api.nvim_list_uis() > 0 then
      vim.cmd('silent! TSUpdateSync')
    end
  end,
}
