local colorscheme = require("lazyvim.plugins.colorscheme")
return {
  -- add catppuccin
  {
    "catppuccin",
    opts = {
      transparent_background = true,
    },
  },

  -- Configure LazyVim to load catppuccin
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha",
    },
  },
}
