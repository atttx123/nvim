local M = {}

-- set the global theme, used at various places like theme switcher, highlights
vim.g.nvchad_theme = "onedark"

-- if theme given, load given theme if given, otherwise nvchad_theme
M.init = function(theme)
   if not theme then
        theme = vim.g.nvchad_theme
    end

    local present, base16 = pcall(require, "base16")

    if present then
        -- first load the base16 theme
        base16(base16.themes(theme), true)

        -- unload to force reload
        package.loaded["colors.highlights" or false] = nil
        -- then load the highlights
        require "colors.highlights"
    end
end

-- returns a table of colors for given or current theme
M.get = function(theme)
    if not theme then
        theme = vim.g.nvchad_theme
    end

    local present, hl_theme = pcall(require, "hl_themes." .. theme)
    if present then
        return hl_theme
    else
        print("\n==============\n")
        print(debug.traceback())
        print("\n==============\n")
    end
end

return M
