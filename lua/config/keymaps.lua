local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Delete without yanking
keymap.set("n", "x", '"_x')

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Save file and quit
keymap.set("n", "<Leader>w", ":update<Return>", opts)
keymap.set("n", "<Leader>q", ":quit<Return>", opts)
keymap.set("n", "<Leader>Q", ":qa<Return>", opts)

-- File explorer with NvimTree
keymap.set("n", "<Leader>f", ":NvimTreeFindFile<Return>", opts)
keymap.set("n", "<Leader>t", ":NvimTreeToggle<Return>", opts)

-- Tabs
keymap.set("n", "te", ":tabedit")
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)
keymap.set("n", "tw", ":tabclose<Return>", opts)

-- Split window 🪟
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)
keymap.set("n", "sd", "<C-w>c", opts)

-- Move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- Resize window
keymap.set("n", "<C-S-h>", "<C-w><")
keymap.set("n", "<C-S-l>", "<C-w>>")
keymap.set("n", "<C-S-k>", "<C-w>+")
keymap.set("n", "<C-S-j>", "<C-w>-")

-- Diagnostics navigation
keymap.set("n", "<C-j>", function()
	vim.diagnostic.goto_next()
end, opts)

-- Codeium shortcuts (Add these lines)
keymap.set("i", "<C-Space>", "codeium#Complete()", { expr = true, noremap = true, silent = true }) -- Trigger Codeium completion in insert mode
vim.keymap.set("n", "<leader>dd", function()
	require("duck").hatch("🦆", 6)
end, {}) -- A pretty fast duck
vim.keymap.set("n", "<leader>dc", function()
	require("duck").hatch("🐈", 9)
end, {}) -- Quite a mellow cat
vim.keymap.set("n", "<leader>dv", function()
	require("duck").hatch("🦀", 7)
end, {}) -- Quite a mellow cat
vim.keymap.set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>")
vim.cmd("command! E lua require('emoji').insert()")
