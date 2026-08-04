return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
    { 'folke/trouble.nvim', lazy = true, cmd = 'TroubleToggle' },
  },

  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local transform_mod = require("telescope.actions.mt").transform_mod

    local trouble = require("trouble")
    local trouble_telescope = require("trouble.sources.telescope")
    local builtin = require('telescope.builtin')

    -- or create your custom action
    local custom_actions = transform_mod({
      open_trouble_qflist = function(prompt_bufnr)
        trouble.toggle("quickfix")
      end,
    })

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        layout_strategy = "bottom_pane",
        layout_config = {
          bottom_pane = {
            height = 0.5,
            preview_cutoff = 0,
          },
        },
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--hidden',
            '--glob=!*.o',
            '--glob=!*.obj',
        },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
            ["<C-t>"] = trouble_telescope.open,
          },
        },
      },
    })

    telescope.load_extension("fzf")

    -- prompt for a search directory, defaulting to the current file's directory
    local function prompt_dir()
      local default_dir = vim.fn.expand('%:p:h')
      local dir = vim.fn.input('Search directory > ', default_dir, 'dir')
      if dir == '' then
        return default_dir
      end
      return dir
    end

    -- set keymaps
    local keymap = vim.keymap -- for conciseness
    keymap.set('n', '<leader>pf', builtin.find_files, {})
    keymap.set('n', '<leader>pF', function()
        builtin.find_files({ cwd = prompt_dir() })
    end)
    keymap.set('n', '<C-p>', builtin.git_files, {})
    keymap.set('n', '<leader>ps', function()
        builtin.grep_string({ search = vim.fn.input("Grep > ") })
    end)
    keymap.set('n', '<leader>pS', function()
        local dir = prompt_dir()
        builtin.grep_string({ search = vim.fn.input("Grep > "), cwd = dir })
    end)
    keymap.set('n', '<leader>vh', builtin.help_tags, {})
 end,
}
