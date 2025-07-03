return {
  'rcarriga/nvim-notify',
  lazy = false,
  enabled = true,
  version = 'v3.15.0',
  config = function()
    local notify = require('notify')
    vim.notify = notify
    notify.setup({
      background_colour = '#1f1f1f',
      fps = 30,
      icons = {
        DEBUG = '',
        ERROR = '󰅚',
        INFO = '󰋽',
        TRACE = '',
        WARN = '󰀪',
      },
      level = 2,
      minimum_width = 50,
      render = 'default',
      stages = 'fade_in_slide_out',
      time_formats = {
        notification = '%T',
        notification_history = '%FT%T',
      },
      timeout = 5000,
      top_down = true,
    })
  end,
}
