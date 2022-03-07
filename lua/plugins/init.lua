-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

local present, packer = pcall(require, "packer")

if not present then
   local packer_path = vim.fn.stdpath "data" .. "/site/pack/packer/opt/packer.nvim"

   print "Cloning packer.."
   -- remove the dir before cloning
   vim.fn.delete(packer_path, "rf")
   vim.fn.system {
      "git",
      "clone",
      "https://github.com/wbthomason/packer.nvim",
      "--depth",
      "20",
      packer_path,
   }

   vim.cmd "packadd packer.nvim"
   present, packer = pcall(require, "packer")

   if present then
      print "Packer cloned successfully."
   else
      error("Couldn't clone packer !\nPacker path: " .. packer_path .. "\n" .. packer)
   end
end

packer.startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        "NvChad/nvim-base16.lua",
        after = "packer.nvim",
        config = function()
            require("colors").init()
        end,
    }

    use {
        "kyazdani42/nvim-web-devicons",
        after = "nvim-base16.lua",
        config = function() require('plugins.configs.icons').setup() end,
    }

    use {
        'kyazdani42/nvim-tree.lua',
        after = 'nvim-web-devicons', -- optional, for file icon
        config = function() require('plugins.configs.nvimtree').setup() end,
        setup = function() require('mappings').nvimtree() end,
    }

    use {
        "nvim-telescope/telescope.nvim",
        requires = {
            'nvim-lua/plenary.nvim'
        },
        config = function() require('plugins.configs.telescope').setup() end,
        setup = function() require("mappings").telescope() end,
    }

    use {
        "feline-nvim/feline.nvim",
        after = "nvim-web-devicons",
        config = function() require('plugins.configs.statusline').setup() end,
    }

    use {
        "akinsho/bufferline.nvim",
        after = "nvim-web-devicons",
        config = function() require('plugins.configs.bufferline').setup() end,
    }

    use {
        "nvim-treesitter/nvim-treesitter",
        event = "BufRead",
        config = function() require("plugins.configs.treesitter").setup() end,
        run = ":TSUpdate",
    }

    use {
        "ludovicchabant/vim-gutentags",
    }

    use {
        "neovim/nvim-lspconfig",
        opt = true,
        config = function() require('plugins.configs.lspconfig').setup() end,
    }

end)
