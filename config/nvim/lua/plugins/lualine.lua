return {
  "nvim-lualine/lualine.nvim",
  lazy = true,
  event = { "BufReadPost", "BufAdd", "BufNewFile" },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")
    local icons = require("config.icons").icons

    local function diff_source()
      ---@diagnostic disable-next-line: undefined-field
      local gitsigns = vim.b.gitsigns_status_dict
      if gitsigns then
        return {
          added = gitsigns.added,
          modified = gitsigns.changed,
          removed = gitsigns.removed,
        }
      end
    end

    local colors = {
      bg = "#202328",
      fg = "#bbc2cf",
      yellow = "#ECBE7B",
      cyan = "#008080",
      darkblue = "#081633",
      green = "#98be65",
      orange = "#FF8800",
      violet = "#a9a1e1",
      magenta = "#c678dd",
      blue = "#51afef",
      red = "#ec5f67",
    }

    local conditions = {
      buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
      end,
      hide_in_width = function()
        return vim.fn.winwidth(0) > 80
      end,
      check_git_workspace = function()
        local filepath = vim.fn.expand("%:p:h")
        local gitdir = vim.fn.finddir(".git", filepath .. ";")
        return gitdir and #gitdir > 0 and #gitdir < #filepath
      end,
    }

    -- Config
    local config = {
      options = {
        component_separators = "",
        section_separators = "",
        globalstatus = true,
        theme = {
          normal = { c = { fg = colors.fg } },
          inactive = { c = { fg = colors.fg } },
        },
      },
      sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        -- These will be filled later
        lualine_c = {},
        lualine_x = {},
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
      },
    }

    -- Inserts a component in lualine_c at left section
    local function ins_left(component)
      table.insert(config.sections.lualine_c, component)
    end

    -- Inserts a component in lualine_x at right section
    local function ins_right(component)
      table.insert(config.sections.lualine_x, component)
    end

    ins_left({
      function()
        return "▊"
      end,
      color = { fg = colors.blue },
      padding = { left = 0, right = 1 },
    })
    ins_left({
      function()
        return ""
      end,
      color = function()
        local mode_color = {
          n = colors.red,
          i = colors.green,
          v = colors.blue,
          [""] = colors.blue,
          V = colors.blue,
          c = colors.magenta,
          no = colors.red,
          s = colors.orange,
          S = colors.orange,
          [""] = colors.orange,
          ic = colors.yellow,
          R = colors.violet,
          Rv = colors.violet,
          cv = colors.red,
          ce = colors.red,
          r = colors.cyan,
          rm = colors.cyan,
          ["r?"] = colors.cyan,
          ["!"] = colors.red,
          t = colors.red,
        }
        return { fg = mode_color[vim.fn.mode()] }
      end,
      padding = { right = 1 },
    })
    ins_left({
      "filesize",
      cond = conditions.buffer_not_empty,
      color = { fg = colors.green, gui = "bold" },
    })
    ins_left({
      "filename",
      icon = string.gsub(icons.ui.Project, "%s+", ""),
      cond = conditions.buffer_not_empty,
      color = { fg = colors.magenta, gui = "bold" },
    })
    ins_left({
      "branch",
      icon = string.gsub(icons.ui.Branch, "%s+", ""),
      color = { fg = colors.violet, gui = "bold" },
    })
    ins_left({
      "diff",
      colored = true,
      symbols = { added = icons.git.added, modified = icons.git.modified, removed = icons.git.removed },
      diff_color = {
        added = { fg = colors.green },
        modified = { fg = colors.orange },
        removed = { fg = colors.red },
      },
      sources = diff_source,
      cond = conditions.hide_in_width,
    })

    -- Insert mid section. You can make any number of sections in neovim :)
    -- for lualine it's any number greater then 2
    ins_left({
      function()
        return "%="
      end,
    })

    ins_left({
      function()
        local msg = "No Active Lsp"
        local bufnr = vim.api.nvim_get_current_buf()
        local clients = vim.lsp.get_clients({ bufnr = bufnr })
        if next(clients) == nil then
          return msg
        end
        local c = {}
        for _, client in pairs(clients) do
          table.insert(c, client.name)
        end
        return table.concat(c, " ")
      end,
      icon = icons.ui.Gears,
      color = { fg = colors.orange, gui = "bold" },
    })

    -- Add components to right sections
    ins_right({
      "diagnostics",
      sources = { "nvim_diagnostic" },
      symbols = {
        error = icons.diagnostics.Error,
        warn = icons.diagnostics.Warn,
        info = icons.diagnostics.Info,
        hint = icons.diagnostics.Hint,
      },
      diagnostics_color = {
        color_error = { fg = colors.red },
        color_warn = { fg = colors.yellow },
        color_info = { fg = colors.cyan },
      },
    })
    ins_right({
      "o:encoding",
      cond = conditions.hide_in_width,
      color = { fg = colors.green, gui = "bold" },
    })
    ins_right({ "filetype", color = { fg = colors.green, gui = "bold" } })
    ins_right({
      "fileformat",
      icons_enabled = true,
      color = { fg = colors.green, gui = "bold" },
    })
    ins_right({ "location", color = { fg = colors.green, gui = "bold" } })
    ins_right({ "progress", color = { fg = colors.green, gui = "bold" } })
    ins_right({
      function()
        return "▊"
      end,
      color = { fg = colors.blue },
      padding = { left = 1 },
    })
    lualine.setup(config)
  end,
}
