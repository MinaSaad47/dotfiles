if vim.fn.exists("g:vscode") == 0 then
    require('settings')
    require('mappings')
    require('packer-conf')
    require('colorscheme-conf')
    require('plugins-conf')
end
