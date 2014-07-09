function! FormatApex()
	" Mark current location
	normal mz
	
	" Delete extra lines
	:%s/\s\+$//e
	:%s/\n\{3,}/\r\r/e
	
	" Delete blank lines before } after ; or }
	:%s/;\s*\n\s*\n\s*}/;\r}/ge
	:%s/}\s*\n\s*\n\s*}/}\r}/ge
	
	" Delete blank lines before catch and else
	:%s/}\s*\n\s*\n\s*catch/}\rcatch/ge
	:%s/}\s*\n\s*\n\s*else/}\relse/ge
	
	" Put space after if/for/while/catch
	:%s/if(/if (/ge
	:%s/for(/for (/ge
	:%s/while(/while (/ge
	:%s/catch(/catch (/ge
	
	" Put space between ){
	:%s/){/) {/ge
	
	" Fix indentations
	normal gg=G
	
	" return to starting point
	normal `z
endfunction
command! FormatApex call FormatApex()
command! FixApex call FormatApex()