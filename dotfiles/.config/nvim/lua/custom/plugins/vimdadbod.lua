return{
    {
        'kristijanhusak/vim-dadbod-ui',
        dependencies = {
            { 'tpope/vim-dadbod', lazy = true },
            { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' } }, -- Remove lazy = true here
        },
        cmd = { 'DBUI', 'DBUIToggle', 'DBUIAddConnection', 'DBUIFindBuffer' },
        init = function()
            vim.g.dbs = {
                nop = 'mysql://root:password@127.0.0.1:3307/CVSBNOP',
            }
        end,
    },
}
