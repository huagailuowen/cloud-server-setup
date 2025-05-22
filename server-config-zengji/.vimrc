se number
se nocompatible
se cursorline
se mouse=a
se backspace=indent,eol,start

se autoindent
se cindent
se tabstop=4
se shiftwidth=4

colo ron

se splitright
se splitbelow
se fileencodings=utf8,ucs-bom,gbk,cp936,gb2312,gb18030,default,latin1

let g:airline#extensions#tabline#enabled = 1

nnoremap <C-_> :TComment<CR>
inoremap <C-_> <Esc>:TComment<CR>i
vnoremap <C-_> :TComment<CR>

func! CloseTer()
	let l:teId = bufwinnr("!system")
	if teId > 0
		exec teId .. "wincmd q"
	endif
endfunc

map <F11> :call CompileRunGcc()<CR>
imap <F11> <esc>:call CompileRunGcc()<CR>
func! CompileRunGcc()
    if &filetype == 'c'
		exec "w"
		exec "!g++ % -o %<"
		exec "! ./%<"
	elseif &filetype == 'cpp'|| expand("%:e")== 'in'
		" exec "w \| !g++ % -o %< -std=c++14 -O2 -Wall && \time ./%<"
		wa
		call CloseTer()
		:ter ++shell ++rows=7 g++ %<.cpp -o %< -std=c++14 -O2 -Wall && \time -f" \%U seconds" ./%< < ./%<.in
		let &t_SI .= "\<Esc>[5 q"
	elseif &filetype == 'java'
        exec "!javac %"
		exec "w"
		exec "!java %<"
	elseif &filetype == 'sh'
		exec "w"
		" exec "!sh ./%"
		:!sh ./%
	elseif &filetype == 'python'
		wa
		call CloseTer()
		:ter ++shell ++rows=10 python %
		let &t_SI .= "\<Esc>[5 q"
	endif
endfunc
