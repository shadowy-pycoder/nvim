local colors = {
  blue = '#61afef',
  green = '#89d185',
  purple = '#c678dd',
  cyan = '#56b6c2',
  red1 = '#e06c75',
  red2 = '#be5046',
  yellow = '#e5c07b',
  fg = '#b0b0b0',
  bg = '#1f1f1f',
  gray1 = '#b0b0b0',
  gray2 = '#2a2d2e',
  gray3 = '#454545',
}

return {
  normal = {
    a = { fg = colors.bg, bg = colors.green, gui = 'bold' },
    b = { fg = colors.fg, bg = colors.gray3 },
    c = { fg = colors.fg, bg = colors.gray2 },
  },
  command = { a = { fg = colors.bg, bg = colors.yellow, gui = 'bold' } },
  insert = { a = { fg = colors.bg, bg = colors.blue, gui = 'bold' } },
  visual = { a = { fg = colors.bg, bg = colors.purple, gui = 'bold' } },
  terminal = { a = { fg = colors.bg, bg = colors.cyan, gui = 'bold' } },
  replace = { a = { fg = colors.bg, bg = colors.red1, gui = 'bold' } },
  inactive = {
    a = { fg = colors.gray1, bg = colors.bg, gui = 'bold' },
    b = { fg = colors.gray1, bg = colors.bg },
    c = { fg = colors.gray1, bg = colors.gray2 },
  },
}
