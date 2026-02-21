return {
  'selimacerbas/markdown-preview.nvim',
  dependencies = { 'selimacerbas/live-server.nvim' },
  config = function()
    require('markdown_preview').setup({
      -- all optional; sane defaults shown
      port = 8421,
      open_browser = true,
      debounce_ms = 300,
    })
    local map = function(lhs, rhs, desc)
      vim.keymap.set('n', lhs, rhs, { desc = desc, silent = true })
    end
    map('<leader>mds', '<cmd>MarkdownPreview<cr>', 'Markdown: Start preview')
    map('<leader>mdd', '<cmd>MarkdownPreviewStop<cr>', 'Markdown: Stop preview')
    map('<leader>mdr', '<cmd>MarkdownPreviewRefresh<cr>', 'Markdown: Refresh preview')
  end,
}
