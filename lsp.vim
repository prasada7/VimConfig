let lspOpts = #{autoHighlightDiags: v:true}
autocmd User LspSetup call LspOptionsSet(lspOpts)

let lspServers = [
    \#{
	\    name: 'golang',
	\    filetype: ['go', 'gomod'],
    \    path: '/home/prasada7/go/bin/gopls',
	\    args: ['serve'],
	\ }]
autocmd User LspSetup call LspAddServer(lspServers)

nmap <silent><nowait> gd :LspGotoDefinition<CR>
nmap <silent><nowait> gy :LspGotoTypeDef<CR>
nmap <silent><nowait> gi :LspGotoImpl<CR>
nmap <silent><nowait> gr :LspIncomingCalls<CR>
