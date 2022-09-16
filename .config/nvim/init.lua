if vim.fn.exists("g:vscode") == 0 then
    require('packer-conf')
    require('settings')
    require('mappings')
    require('colorscheme-conf')
    require('plugins-conf')
end
