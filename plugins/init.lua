return {
  -- You can disable default plugins as follows:
  { "subnut/nvim-ghost.nvim", enabled = true, lazy = false },
  {
    "glacambre/firenvim",
    enabled = true,
    lazy = false,
    config = function()

      vim.fn["firenvim#install"](0)
      vim.g.firenvim_config = {
        globalSettings = {
          alt = "all",
        },
        localSettings = {
          [".*"] = {
            selector = "textarea",
            takeover = "always",
            priority = 0,
            content = "markdown",
          },

          ["https?://[^/]*/.*cliff.*"] = {
            content = "hoon",
            filename = "{pathname}.hoon",
          },
        },
      }

      vim.cmd [[
        augroup firenvim_urbit_land
            autocmd!
            autocmd BufEnter * nested if match(expand('<afile>'), 'cliff-edit') != -1 | setlocal filetype=hoon | let fname = expand('%:t:r') | let fname = substitute(fname, '\zs.*-now-', '', '') | let fname = substitute(fname, '\(.*\)-hoon', '\1', '') | let fname = substitute(fname, '-', '/', 'g') | execute 'file' fname.'.hoon' | endif
        augroup END
        ]]
    end,
  },
  { "goolord/alpha-nvim", enabled = true },
  { "max397574/better-escape.nvim", enabled = true },
  {
    "urbit/hoon.vim",
    enabled = true,
    lazy = false,
  },
  -- You can also add new plugins here as well:
  {
    "nvim-treesitter/nvim-treesitter",
    enabled = true,
  },
  { "nvim-treesitter/playground", cmd = "TSHighlightCapturesUnderCursor", dependencies = { "nvim-treesitter" } },
  { "lvimuser/lsp-inlayhints.nvim", config = true },
  {
    "zbirenbaum/copilot.lua",
    lazy = true,
    enabled = true,
    event = "BufEnter",
    cmd = "Copilot",
    config = function()
      require("copilot").setup {
        suggestion = { enabled = false },
        panel = { enabled = false },
      }
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "zbirenbaum/copilot.lua" },
    event = "BufEnter",
    lazy = true,
    enabled = true,
    config = function() require("copilot_cmp").setup() end,
  },

  {
    "MunifTanjim/prettier.nvim",
    lazy = false,
    enabled = true,
    cmd = "Prettier",
  },
  {
    "rafi/awesome-vim-colorschemes",
    enabled = true,
  },
  {
    "NvChad/nvim-colorizer.lua",
    event = "User AstroFile",
  },
  {
    "folke/zen-mode.nvim",
    cmd = { "ZenMode" },
    opts = {
      window = {
        backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
        -- height and width can be:
        -- * an absolute number of cells when > 1
        -- * a percentage of the width / height of the editor when <= 1
        -- * a function that returns the width or the height
        width = 120, -- width of the Zen window
        height = 1, -- height of the Zen window
        -- by default, no options are changed for the Zen window
        -- uncomment any of the options below, or add other vim.wo options you want to apply
        options = {
          -- signcolumn = "no", -- disable signcolumn
          -- number = false, -- disable number column
          -- relativenumber = false, -- disable relative numbers
          -- cursorline = false, -- disable cursorline
          -- cursorcolumn = false, -- disable cursor column
          -- foldcolumn = "0", -- disable fold column
          -- list = false, -- disable whitespace characters
        },
      },
      plugins = {
        -- disable some global vim options (vim.o...)
        -- comment the lines to not apply the options
        options = {
          enabled = true,
          ruler = false, -- disables the ruler text in the cmd line area
          showcmd = false, -- disables the command in the last line of the screen
        },
        twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
        gitsigns = { enabled = false }, -- disables git signs
        tmux = { enabled = false }, -- disables the tmux statusline
        -- this will change the font size on kitty when in zen mode
        -- to make this work, you need to set the following kitty options:
        -- - allow_remote_control socket-only
        -- - listen_on unix:/tmp/kitty
        kitty = {
          enabled = false,
          font = "+4", -- font size increment
        },
      },
    },
  },
  {
    "karb94/neoscroll.nvim",
    opts = {
      -- All these keys will be mapped to their corresponding default scrolling animation
      mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
      hide_cursor = true, -- Hide cursor while scrolling
      stop_eof = true, -- Stop at <EOF> when scrolling downwards
      use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
      respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
      cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
      easing_function = nil, -- Default easing function
      pre_hook = nil, -- Function to run before the scrolling animation starts
      post_hook = nil, -- Function to run after the scrolling animation ends
    },
  },
}
