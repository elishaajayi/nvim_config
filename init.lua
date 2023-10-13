require("elisha")

-- Theme
vim.cmd("colorscheme dracula")

-- Lualine
require('lualine').setup()

-- Lsp
require('lspconfig').clangd.setup({})

-- Configure ALE linters for C code with Betty
vim.g.ale_linters = {
	c = {'betty-style', 'betty-doc'}
}

require("elisha.after.harpoon")

-- Set tabs to be betty compliant
vim.opt.tabstop = 4 
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4 

-- Function to compile and run C code with linked files
function CompileAndRun()
	local linked_files = vim.fn.input('Enter the names of linked files: ')

	if linked_files ~= '' then
		local command = string.format('gcc -Wall -pedantic -Werror -Wextra -std=gnu89 %s %s -o %s && ./%s', vim.fn.expand('%'), linked_files, vim.fn.expand('%:r'), vim.fn.expand('%:r'))
		vim.api.nvim_command('!' .. command)
	else
		print('No linked files provided. Compiling only the current file.')
		local command = string.format('gcc -Wall -pedantic -Werror -Wextra -std=gnu89 %s -o %s && ./%s', vim.fn.expand('%'), vim.fn.expand('%:r'), vim.fn.expand('%:r'))
		vim.api.nvim_command('!' .. command)
	end
end

-- Define a key mapping to trigger the custom command
vim.api.nvim_set_keymap('n', '<C-M-l>', ':lua CompileAndRun()<CR>', { noremap = true, silent = true })

-- Set the cursor shape to an underscore
vim.cmd[[set guicursor+=n:hor20-Cursor/lCursor]]

-- Function to open terminal window
function OpenTerminal()
	vim.cmd('botright split')
	vim.cmd('term')
	vim.api.nvim_exec([[resize 8]], true)
	vim.cmd('startinsert')
end

vim.api.nvim_set_keymap('n', '<leader>tt', ':lua OpenTerminal()<CR>', { noremap = true, silent = true })

-- vim.api.nvim_set_keymap('n', '<C-M-I>', ':lua RunPythonFile()<CR>', { noremap = true, silent = true })

