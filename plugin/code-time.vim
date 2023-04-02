let s:vim_home = $HOME . "/.vim"
let s:data_dir = s:vim_home . "/plugged/code-time"
let s:data_file = "/data"
let s:data_path = s:data_dir . s:data_file
let s:last_file_type = ""

function! s:StartEdit()
	if empty(&filetype) || &filetype =~ "-MiniBufExplorer-" || &filetype =~ "--NO NAME--" || &filetype =~ "^term:" || &filetype == s:last_file_type || &filetype =~ "nerdtree" || &filetype =~ "list" || &filetype =~ "floaterm"
		return
	endif
	let start_time = localtime()
	let str = "start: " . start_time . " " . &filetype
	let s:last_file_type = &filetype
	call writefile([str], s:data_path, "a")
endfunction

function! s:EndEdit()
	if s:last_file_type == ""
		return
	endif
	let end_time = localtime()
	let str = "end: " . end_time
	call writefile([str], s:data_path, "a")
endfunction


autocmd BufEnter * call s:StartEdit()
if exists('##QuitPre')
    autocmd QuitPre * call s:EndEdit()
endif
