return {
    'VebbNix/lf-vim',
    {
        'alker0/chezmoi.vim',
        lazy = false,
        init = function()
            vim.g['chezmoi#use_tmp_buffer'] = true
        end,
    },
    "MTDL9/vim-log-highlighting",
}
