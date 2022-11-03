set number
set relativenumber
set tabstop=2
set shiftwidth=2
set autoindent
set mouse=a

syntax on

call plug#begin('~/.config/nvim/plugged')

Plug 'SirVer/ultisnips'

Plug 'neoclide/coc.nvim', {'branch' : 'release'}

let g:coc_global_extensions = ['coc-tslint-plugin', 'coc-tsserver', 'coc-css', 'coc-html', 'coc-json', 'coc-yank', 'coc-prettier']

Plug 'ianks/vim-tsx'
Plug 'leafgarland/typescript-vim'

Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'ap/vim-css-color'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'windwp/nvim-ts-autotag'
Plug 'nvim-treesitter/nvim-treesitter', { 'do': 'TSUpdate' }
Plug 'windwp/nvim-autopairs'
Plug 'neovim/nvim-lspconfig'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }

call plug#end()

lua << EOF
require("nvim-autopairs").setup({
	enable_check_braket_line = false
})
EOF

au BufNewFile,BufRead *.ts setlocal filetype=typescript
au BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx

set guifont=JetBrains\ Mono:h11

let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0
let NERDTreeShowHidden = 1

let g:syntastic_mode_map = { 'mode' : 'active', 'active_filetypes' : ['javascript, typescript']}

set statusline+=%#warningmsg#
set statusline+=${SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_javascript_checkers = ['eslint']

colorscheme angr
nmap nerd :NERDTreeToggle<CR>
nmap <Leader>py <Plug>(Prettier)

" Terminal Function
let g:term_buf = 0
let g:term_win = 0
function! TermToggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction

" Toggle terminal on/off (neovim)
nnoremap <A-t> :call TermToggle(12)<CR>
inoremap <A-t> <Esc>:call TermToggle(12)<CR>
tnoremap <A-t> <C-\><C-n>:call TermToggle(12)<CR>

" Terminal go back to normal mode
tnoremap <Esc> <C-\><C-n>
tnoremap :q! <C-\><C-n>:q!<CR>
