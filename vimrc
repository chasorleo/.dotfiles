" Modeline and Notes {{{

" vim:shiftwidth=2:tabstop=8:expandtab
" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={{{,}}} foldlevel=0 foldmethod=marker:

" }}}

" Environment {{{

    " Identify platform {{{

        silent function! WINDOWS()
            return  (has('win16') || has('win32') || has('win64'))
        endfunction
    " }}}

    " Basics {{{

        set nocompatible        " Must be first line
    " }}}

" }}}

" General {{{

    filetype plugin indent on   " Automatically detect file types.
    syntax on                   " Syntax highlighting
    set mouse=a                 " Automatically enable mouse usage
    set mousehide               " Hide the mouse cursor while typing
    scriptencoding utf-8
    " Save when losing focus
    au FocusLost * :silent! wall

    " Resize splits when the window is resized
    au VimResized * :wincmd =
    " Automatically switch to the current file directory when
    " a new buffer is opened;
    " Always switch to the current file directory
    autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
    set autowrite                       " Automatically write a file when leaving a modified buffer
    highlight clear CursorLineNr    " Remove highlight color from current line number

    set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
    set virtualedit=onemore             " Allow for cursor beyond last character
    set history=1000                    " Store a ton of history (default is 20)
    set hidden                          " Allow buffer switching without saving
    set spell
    set spelllang=en
    nnoremap <F6> :set spell!<CR>
    autocmd GUIEnter * set vb t_vb=
    set hidden                          " remember undo after quitting

    " Restore cursor to file position in previous editing session
    function! ResCur()
        if line("'\"") <= line("$")
            normal! g`"
            return 1
        endif
    endfunction

    augroup resCur
        autocmd!
        autocmd BufWinEnter * call ResCur()
    augroup END
    " Set default working directory at c:\Users\s3458356\Codeg\ 
    "cd c:\users\s3458356\abaqus root\recSrfHomFEM\
    set autochdir
    set autoread
    " FORTRAN folding
    augroup fortranflod
        au! BufRead,BufEnter,BufNewFile *.f90,*.for,*.f setfiletype fortran
        set foldmethod=syntax
        let fortran_fold = 1
        let fortran_fold_conditionals = 1
        "let fortran_fold_multilinecomments= 1
    augroup END

" }}}

" Vim UI {{{

    set background=dark " Assume a dark background
    "set background=light        " Assume a light background
    let g:solarized_termcolors=256
    let g:solarized_termtrans=1
    let g:solarized_contrast="normal"
    let g:solarized_visibility="normal"
    color solarized
    "color github
    "color lucius
    "color molokai
    "color atom-dark

    set tabpagemax=15               " Only show 15 tabs
    set showmode                    " Display the current mode
    set cursorline                  " Highlight current line

    highlight clear SignColumn      " SignColumn should match background
    highlight clear LineNr          " Current line number row will have same background color in relative mode

    if has('cmdline_info')
        set ruler                   " Show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
        set showcmd                 " Show partial commands in status line and
                                    " Selected characters/lines in visual mode
    endif

    if has('statusline')
        set laststatus=2
        set statusline=%<%f\                     " Filename
        set statusline+=%w%h%m%r                 " Options
        set statusline+=\ [%{&ff}/%Y]            " Filetype
        set statusline+=\ [%{getcwd()}]          " Current dir
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    endif

    set guioptions=e                 " no menus, scrollbars, or other junk
    set backspace=indent,eol,start  " Backspace for dummies
    set linespace=0                 " No extra spaces between rows
    set nu                          " Line numbers on
    set showmatch                   " Show matching brackets/parenthesis
    set incsearch                   " Find as you type search
    set hlsearch                    " Highlight search terms
    set winminheight=0              " Windows can be 0 line high
    set ignorecase                  " Case insensitive search
    set smartcase                   " Case sensitive when uc present
    set wildmenu                    " Show list instead of just completing
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
    set scrolljump=5                " Lines to scroll when cursor leaves screen
    set scrolloff=3                 " Minimum lines to keep above and below cursor
    set foldenable                  " Auto fold code
    set list
    set listchars=tab:›\ ,trail:•,extends:>,precedes:<,eol:¬ " Highlight problematic whitespace
    set vb t_vb=
    set lines=25
    set columns=100
    winp 500 200
    "au GUIEnter * simalt ~x
    "set guifont=Inconsolata:h14:cANSI,Andale_Mono:h10,Menlo:h10,Consolas:h10,Courier_New:h10
    set guifont=Source_Code_Pro:b:h11,Andale_Mono:h10,Menlo:h10,Consolas:h10,Courier_New:h10
    "set guifont=Andale_Mono:h11,Menlo:h10,Consolas:h10,Courier_New:h10
    " Highlight 80th column
    highlight Col80 guifg=#ffffff guibg=#555555
    call matchadd('Col80', '\%81v')

    "" Highlight columns after 90
    execute "set colorcolumn=" . join(range(90,335),',')
    "hi ColorColumn guibg=DimGray guifg=white
    "hi ColorColumn ctermbg=238 guifg=#9dadb0 guibg=#333333 font=Inconsolata:bi:h11

    " Only have cursorline in current window
    autocmd WinLeave * set nocursorline
    autocmd WinEnter * set cursorline

    " Reuse status as window title
    let &titlestring='%{getcwd()}/%f]   %y  #%n   %p%%   %l/%L,%c%V'
    set titlestring+=\ {%{v:servername}}

" }}}

" Formatting {{{

    set nowrap                      " Do not wrap long lines
    nnoremap <F7> :set wrap!<CR>
    set autoindent                  " Indent at the same level of the previous line
    set smartindent
    set shiftwidth=4                " Use indents of 4 spaces
    set expandtab                   " Tabs are spaces, not tabs
    set tabstop=4                   " An indentation every four columns
    set softtabstop=4               " Let backspace delete indent
    set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
    set splitright                  " Puts new vsplit windows to the right of the current
    set splitbelow                  " Puts new split windows to the bottom of the current
    set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
    set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks

" }}}

" Key (re)Mappings {{{

    " The mapleader  ',' as it's in a standard
    let mapleader = ','
    "edit vimrc and source vimrc
    nnoremap <leader>er :tabedit $MYVIMRC<cr>
    "nnoremap <leader>sr :source $MYVIMRC<cr>
    augroup AutoReloadVimRC
        au!
        " automatically reload vimrc when it's saved
        au BufWritePost $MYVIMRC so $MYVIMRC
    augroup END

    " Easier moving in tabs and windows
    noremap <C-j> <C-W>j<C-W>
    noremap <C-k> <C-W>k<C-W>
    noremap <C-l> <C-W>l<C-W>
    noremap <C-h> <C-W>h<C-W>
    nnoremap <silent> <Leader>+ :exe "resize ".(winheight(0) * 3/2)<CR>
    nnoremap <silent> <Leader>- :exe "resize ".(winheight(0) * 2/3)<CR>
    " Maxiamize current viewports
    noremap <F3> <C-W>_<C-W><Bar>
    " Adjust viewports to the same size
    noremap <F4> <C-W>=

    " Copy and Paste with System buffer
    noremap <leader>sy "+yy
    noremap <leader>sp "+gP
    " Wrapped lines goes down/up to next row, rather than next line in file.
    noremap j gj
    noremap k gk
    noremap B ^
    noremap E $

    " Moving between tabs,the following two lines conflict with moving to top and
    " bottom of the screen
    noremap <S-H> gT
    noremap <S-L> gt

    " Most prefer to toggle search highlighting rather than clear the current
    " search results.
    " Key mapping to stop the search highlight
    nnoremap <silent> n   n:call HLNext(0.3)<CR>
    nnoremap <silent> N   N:call HLNext(0.3)<CR>

    function! HLNext(blinktime)
        highlight airline_warning_bold term=bold cterm=bold ctermfg=230 ctermbg=166 gui=bold guifg=#fdf6e3 guibg=#cb4b16
        let [bufnum, lnum, col, off] = getpos('.')
        let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
        let target_pat = '\c\%#'.@/
        let blinks = 2
        for n in range(1,blinks)
            let red = matchadd('airline_warning_bold', target_pat, 101)
            redraw
            exec 'sleep '.float2nr(a:blinktime / (2 * blinks) * 1000).'m'
            call matchdelete(red)
            redraw
            exec 'sleep '.float2nr(a:blinktime / (2 * blinks) * 1000).'m'
        endfor
    endfunction

    nnoremap <silent> <F2>      :nohlsearch<CR>
    inoremap <silent> <F2> <C-O>:nohlsearch<CR>

    " Shortcuts
    " Change Working Directory to that of the current file
    cnoremap cwd lcd %:p:h
    cnoremap cd. lcd %:p:h

    " Visual shifting (does not exit Visual mode)
    vnoremap < <gv
    vnoremap > >gv

    " Allow using the repeat operator with a visual selection (!)
    vnoremap . :normal .<CR>

    " Some helpers to edit mode
    cnoremap %% <C-R>=expand('%:h').'/'<cr>
    cnoremap && <C-R>=expand('%:p')<cr>
    map <leader>w  : w<CR>
    map <leader>ww : w!<CR>
    map <leader>ew : vsp %%<CR>
    map <leader>es : sp &&<CR>
    map <leader>ev : vsp %%
    map <leader>et : tabe<CR>

    " Map <Leader>ff to display all lines with keyword under cursor
    " and ask which one to jump to
    nnoremap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

    " Easier horizontal scrolling
    noremap zl zL
    noremap zh zH

    "Wrap selection in if, while, or for  
    nnoremap <Leader>if m`Oif(){<Esc>jo}<Esc>``v><Esc>k^wa
    nnoremap <Leader>for m`Ofor(){<Esc>jo}<Esc>``v><Esc>k^wa
    nnoremap <Leader>while m`Owhile(){<Esc>jo}<Esc>``v><Esc>k^wa
    vnoremap <Leader>if <Esc>`<Oif(){<Esc>`>o}<Esc>gv><Esc>`<k^wa
    vnoremap <Leader>for <Esc>`<Ofor(){<Esc>`>o}<Esc>gv><Esc>`<k^wa
    vnoremap <Leader>while <Esc>`<Owhile(){<Esc>`>o}<Esc>gv><Esc>`<k^wa

    " Copy current file full path, name and echo full path
    noremap <silent> <Leader>cp :let @* = expand("%:p")<CR>
    noremap <silent> <Leader>cf :let @* = expand("%:t")<CR>
    noremap <Leader>ef :echo expand("%:p")<CR>

    " Quick substitution the word under cursor in the current paragraph
    nnoremap <leader>s :'{,'}s/\<<c-r>=expand('<cword>')<cr>\>/
    nnoremap <leader>ss :%s/\<<c-r>=expand('<cword>')<cr>\>/

    " get vim help from word under cursor
    noremap <leader>h <esc>:help <c-r><c-w><cr>

    " Print Message to a New Vsplit
    noremap <leader>pm <esc>:call RedirMessages('messages', 'vnew')<cr>
    noremap <leader>ph <esc>:call RedirMessages('history', 'vnew')<cr>

    " Add surrunding to word or centensce
    vnoremap <leader>" <esc>a"<esc>`<i"<esc>`>2l
    vnoremap <leader>' <esc>a'<esc>`<i'<esc>`>2l
    vnoremap <leader>[ <esc>a]<esc>`<i[<esc>`>2l
    vnoremap <leader>{ <esc>a}<esc>`<i{<esc>`>2l
    vnoremap <leader>( <esc>a)<esc>`<i(<esc>`>2l
    nnoremap <leader>" viw<esc>a"<esc>bi"<esc>el
    nnoremap <leader>' viw<esc>a'<esc>bi'<esc>el
    nnoremap <leader>[ viw<esc>a]<esc>bi[<esc>el
    nnoremap <leader>( viw<esc>a)<esc>bi(<esc>el
    nnoremap <leader>{ viw<esc>a}<esc>bi{<esc>el

    " ,n to insert the time, 'n'ow
    map <leader>n "=strftime("%FT%T%z")<CR>Pa<SPACE>

    " map za to zA to open fold recursively
    nnoremap za zA
" }}}

" Plugins {{{

    " pathogen {{{

        execute pathogen#infect()
    "}}}

    " vim-airline {{{

        " Set configuration options for the statusline plugin vim-airline.
        " Use the powerline theme and optionally enable powerline symbols.
        " If the previous symbols do not render for you then install a
        " powerline enabled font.

        " See `:echo g:airline_theme_map` for some more choices
        " Default in terminal vim is 'dark'
        if !exists('g:airline_theme')
            let g:airline_theme = 'solarized'
        endif
        if !exists('g:airline_powerline_fonts')
            " Use the default set of separators with a few customizations
            let g:airline_left_sep='â€º'  " Slightly fancier than '>'
            let g:airline_right_sep='â€¹' " Slightly fancier than '<'
        endif

        " the separator used on the left side >
          let g:airline_left_sep='>'
        " the separator used on the right side >
          let g:airline_right_sep='<'
          let g:airline_inactive_collapse=1

          if !exists('g:airline_symbols')
            let g:airline_symbols = {}
          endif

    " }}}

    " NerdTree {{{

        noremap <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
        nnoremap <leader>nt :NERDTreeFind<CR>

        let NERDTreeShowBookmarks=1
        let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
        let NERDTreeChDirMode=0
        let NERDTreeQuitOnOpen=1
        let NERDTreeMouseMode=2
        let NERDTreeShowHidden=1
        let NERDTreeKeepTreeInNewTab=1
        "autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
        "autocmd VimEnter * NERDTree
        "autocmd VimEnter * wincmd p
        "autocmd TabEnter * NERDTreeMirror
        "autocmd TabEnter * execute '2' . "wincmd w"
        "autocmd BufEnter * if &modifiable | NERDTreeFind | wincmd p | endif

    " }}}

    " Tabularize {{{

        nnoremap <Leader>a& :Tabularize /&<CR>
        vnoremap <Leader>a& :Tabularize /&<CR>
        nnoremap <Leader>a= :Tabularize /=<CR>
        vnoremap <Leader>a= :Tabularize /=<CR>
        nnoremap <Leader>a: :Tabularize /:<CR>
        vnoremap <Leader>a: :Tabularize /:<CR>
        nnoremap <Leader>a:: :Tabularize /:\zs<CR>
        vnoremap <Leader>a:: :Tabularize /:\zs<CR>
        nnoremap <Leader>a, :Tabularize /,<CR>
        vnoremap <Leader>a, :Tabularize /,<CR>
        nnoremap <Leader>a,, :Tabularize /,\zs<CR>
        vnoremap <Leader>a,, :Tabularize /,\zs<CR>
        nnoremap <Leader>a<Bar> :Tabularize /<Bar><CR>
        vnoremap <Leader>a<Bar> :Tabularize /<Bar><CR>
    " }}}

    " PyMode {{{

        let g:pymode_run = 1
        let g:pymode_lint_checker = "pyflakes"
        let g:pymode_utils_whitespaces = 0
        let g:pymode_options = 1
        let g:pymode_paths = ["c:/Python27/"]
        let g:pymode_syntax = 1
        noremap <Leader>ce :PymodeLintAuto <CR>
    " }}}

    " Indent guide {{{

        set st=4 sw =4 et
        let g:indent_guides_start_level = 2
        let g:indent_guides_guide_size = 1
        let g:indent_guides_enable_on_vim_startup = 1
    " }}}

    " OmniComplete {{{

        if has("autocmd") && exists("+omnifunc")
            autocmd Filetype *
                \if &omnifunc == "" |
                \setlocal omnifunc=syntaxcomplete#Complete |
                \endif
        endif

        hi Pmenu  guifg=#000000 guibg=#F8F8F8 ctermfg=black ctermbg=Lightgray
        hi PmenuSbar  guifg=#8A95A7 guibg=#F8F8F8 gui=NONE ctermfg=darkcyan ctermbg=lightgray cterm=NONE
        hi PmenuThumb  guifg=#F8F8F8 guibg=#8A95A7 gui=NONE ctermfg=lightgray ctermbg=darkcyan cterm=NONE

        " Some convenient mappings
        inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
        inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
        inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
        inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
        inoremap <expr> <C-d>      pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
        inoremap <expr> <C-u>      pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

        " Automatically open and close the popup menu / preview window
        au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
        set completeopt=menu,preview,longest
    " }}}

    " neocomplcache {{{

        "Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
        " Disable AutoComplPop {{{
        let g:acp_enableAtStartup = 0
        let g:neocomplcache_enable_at_startup = 1
        let g:neocomplcache_enable_camel_case_completion = 1
        let g:neocomplcache_enable_smart_case = 1
        let g:neocomplcache_enable_underbar_completion = 1
        let g:neocomplcache_enable_auto_delimiter = 1
        let g:neocomplcache_max_list = 15
        let g:neocomplcache_force_overwrite_completefunc = 1
        " }}}

        " Define dictionary {{{

        let g:neocomplcache_dictionary_filetype_lists = {
            \ 'default' : '',
            \ 'vimshell' : $USERPROFILE.'/.vimshell_hist',
            \ 'scheme' : $USERPROFILE.'/.gosh_completions'
            \ }
        " }}}

        " Define keyword {{{

        if !exists('g:neocomplcache_keyword_patterns')
            let g:neocomplcache_keyword_patterns = {}
        endif
        let g:neocomplcache_keyword_patterns._ = '\h\w*'
        " }}}

        " Plugin key-mappings {{{

            " These two lines conflict with the default digraph mapping of <C-K>
            inoremap <C-k> <Plug>(neosnippet_expand_or_jump)
            snoremap <C-k> <Plug>(neosnippet_expand_or_jump)
            iunmap <cr>
            " <esc> takes you out of insert mode
            inoremap <expr> <esc>   pumvisible() ? "\<c-y>\<esc>" : "\<esc>"
            " <cr> accepts first, then sends the <cr>
            inoremap <expr> <cr>    pumvisible() ? "\<c-y>\<cr>" : "\<cr>"
            " <down> and <up> cycle like <tab> and <s-tab>
            inoremap <expr> <down>  pumvisible() ? "\<c-n>" : "\<down>"
            inoremap <expr> <up>    pumvisible() ? "\<c-p>" : "\<up>"
            " jump up and down the list
            inoremap <expr> <c-d>   pumvisible() ? "\<pagedown>\<c-p>\<c-n>" : "\<c-d>"
            inoremap <expr> <c-u>   pumvisible() ? "\<pageup>\<c-p>\<c-n>" : "\<c-u>"
            " <TAB>: completion.
            inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
            inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"
        " }}}

        " Enable omni completion {{{

            autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
            autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
            autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
            autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
            autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
        " }}}

        " Enable heavy omni completion {{{

            autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
            if !exists('g:neocomplcache_omni_patterns')
              let g:neocomplcache_omni_patterns = {}
            endif
            let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
            let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
            let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
            " For perlomni.vim setting.
            let g:neocomplcache_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
        " }}}

    " }}}

    " Snippets {{{

        " Use honza's snippets.
        let g:neosnippet#snippets_directory='$VIM\vimfiles\bundle\vim-snippets\snippets'

        " Enable neosnippet snipmate compatibility mode
        let g:neosnippet#enable_snipmate_compatibility = 1

        " For snippet_complete marker.
        if has('conceal')
            set conceallevel=2 concealcursor=i
        endif

        " Disable the neosnippet preview candidate window
        " When enabled, there can be too much visual noise
        " especially when splits are used.
        set completeopt-=preview
    " }}}

    " ctrlp {{{

        let g:ctrlp_working_path_mode = 'ra'
        let g:ctrlp_use_caching = 1
        let g:ctrlp_cache_dir=$USERPROFILE.'/.cache/ctrlp'
        let g:ctrlp_cache_cache_on_exit = 0
        nnoremap <silent> <D-t> :CtrlP<CR>
        nnoremap <silent> <D-r> :CtrlPMRU<CR>
        let g:ctrlp_custom_ignore = {
            \ 'dir':  '\.git$\|\.hg$\|\.svn$',
            \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }

        " On Windows use "dir" as fallback command.
        if WINDOWS()
            let s:ctrlp_fallback = 'dir %s /-n /b /s /a-d'
        elseif executable('ag')
            let s:ctrlp_fallback = 'ag %s --nocolor -l -g ""'
        elseif executable('ack')
            let s:ctrlp_fallback = 'ack %s --nocolor -f'
        else
            let s:ctrlp_fallback = 'find %s -type f'
        endif
        let g:ctrlp_user_command = {
            \ 'types': {
                \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
                \ 2: ['.hg', 'hg --cwd %s locate -I .'],
            \ },
            \ 'fallback': s:ctrlp_fallback
        \ }
    "}}}

    " BufExplorer {{{

        " Buffers - explore/next/previous: Alt-F12, F12, Shift-F12.
        nnoremap <silent> <M-F12> :BufExplorer<CR>
        nnoremap <silent> <F12> :bn<CR>
        nnoremap <silent> <S-F12> :bp<CR>
    "}}}

    " Undotree {{{

        nnoremap <F5> :UndotreeToggle<cr>
        if has("persistent_undo")
            set undodir=$USERPROFILE/.undodir/
            set undofile
        endif
    "}}}

    " Latex-Suite {{{

        let g:tex_flavor='latex'
    "}}}

    " Drag visual block {{{

        vmap <expr>  <LEFT>   DVB_Drag('left')
        vmap <expr>  <RIGHT>  DVB_Drag('right')
        vmap <expr>  <DOWN>   DVB_Drag('down')
        vmap <expr>  <UP>     DVB_Drag('up')
        vmap <expr>  D        DVB_Duplicate()
    "}}}

    " Latex-Suite {{{

        filetype plugin on   " Automatically detect file types.
        filetype indent on   " Automatically detect file types.
        let g:tex_flavor='latex'
        let g:Tex_DefaultTargetFormat = 'pdf'
        let g:Tex_MultipleCompileFormats='pdf, aux'
        let g:Tex_ViewRule_pdf = 'c:\Users\s3458356\program\SumatraPDF\SumatraPDF.exe'
        set shellslash
        autocmd BufEnter *.tex :set wrap linebreak nolist

    " }}}

" }}}
