local utils = require 'utils'

local map_wrapper = utils.map

-- This is a wrapper function made to disable a plugin mapping from chadrc
-- If keys are nil, false or empty string, then the mapping will be not applied
-- Useful when one wants to use that keymap for any other purpose
local map = function(...)
    local keys = select(2, ...)
    if not keys or keys == "" then
        return
    end
    map_wrapper(...)
end

local M = {}

-- these mappings will only be called during initialization
M.misc = function()
    local function non_config_mappings()
        -- Don't copy the replaced text after pasting in visual mode
        map_wrapper("v", "p", '"_dP')

        -- buffer & tab
        map_wrapper("n", "K", ':bn<CR>')
        map_wrapper("n", "J", ':bp<CR>')

        map_wrapper("n", "<leader>]", ':tabn<CR>')
        map_wrapper("n", "<leader>[", ':tabp<CR>')

    end

    non_config_mappings()
end

M.nvimtree = function()
    map('n', "<leader>n", ":NvimTreeToggle <CR>")
end

M.telescope = function()
    map('n', '<leader>ff', ":Telescope find_files<CR>")
    map('n', '<leader>fg', ":Telescope live_grep<CR>")
    map('n', '<leader>fb', ":Telescope buffers<CR>")
    map('n', '<leader>fh', ":Telescope help_tags<CR>")
end

return M
