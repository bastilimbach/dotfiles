-- Shared based plugins for VSCode and Neovim

-- Byte-compiled Lua module cache
vim.loader.enable()

-- Clone lazy.nvim if not already installed
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git', '--branch=stable', lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin definitions
local base_plugins = {
  -- Provides mappings to easily change surroundings in pairs.
  { 'tpope/vim-surround', event = 'VeryLazy' },
  -- Adds various text objects to give you more targets to operate on.
  { 'wellle/targets.vim', event = 'VeryLazy' },
  -- Makes plugin actions repeatable using dot.
  { 'tpope/vim-repeat', event = 'VeryLazy' },
  -- Automatically adjusts 'shiftwidth' and 'expandtab' heuristically based on the current file.
  { 'tpope/vim-sleuth', event = { 'BufReadPost', 'BufNewFile' } },
  -- Highlight unique character in every word to help with f, F.
  {
    'unblevable/quick-scope',
    event = 'VeryLazy',
    init = function()
      vim.g.qs_highlight_on_keys = { 'f', 'F', 't', 'T' }
    end,
  },
  -- Jump vertically using two characters.
  {
    'justinmk/vim-sneak',
    event = 'VeryLazy',
    init = function()
      vim.g['sneak#label'] = 1
    end,
  },
  -- Smart and Powerful commenting plugin for neovim.
  {
    'numToStr/Comment.nvim',
    event = 'VeryLazy',
    config = function()
      require('Comment').setup {}
    end,
  },

  -- Break bad habits, master Vim motions. (disabled for now — was a test)
  -- {
  --   'm4xshen/hardtime.nvim',
  --   event = 'VeryLazy',
  --   dependencies = { 'MunifTanjim/nui.nvim' },
  --   config = function()
  --     require('hardtime').setup {
  --       disable_mouse = false,
  --     }
  --   end,
  -- },
}

-- Set up lazy.nvim with the shared plugins plus any environment-specific extras.
-- Call exactly once from the env config (neovim.vim / vscode.vim).
return function(extra)
  if extra then
    vim.list_extend(base_plugins, extra)
  end
  require('lazy').setup(base_plugins)
end
