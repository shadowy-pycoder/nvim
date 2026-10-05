return {
  'selimacerbas/mdkite.nvim',
  dependencies = { 'selimacerbas/kitehost.nvim' },
  config = function()
    require('mdkite').setup({
      -- all optional; sane defaults shown
      instance_mode = 'takeover', -- "takeover" (one tab) or "multi" (tab per instance)
      port = 0, -- 0 = auto (8421 for takeover, OS-assigned for multi)
      open_browser = true,
      debounce_ms = 300,
    })
    local map = function(lhs, rhs, desc)
      vim.keymap.set('n', lhs, rhs, { desc = desc, silent = true })
    end
    map('<leader>mds', '<cmd>MdKite start<cr>', 'Markdown: Start preview')
    map('<leader>mdd', '<cmd>MdKite stop<cr>', 'Markdown: Stop preview')
    map('<leader>mdr', '<cmd>MdKite refresh<cr>', 'Markdown: Refresh preview')
  end,
}
