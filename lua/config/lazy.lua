local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		{
			"LazyVim/LazyVim",
			import = "lazyvim.plugins",
			opts = {
				colorscheme = "sonokai",
				news = {
					lazyvim = true,
					neovim = true,
				},
			},
		},
		{
			"Exafunction/codeium.nvim",
			dependencies = {
				"nvim-lua/plenary.nvim",
			},
			config = function()
				require("codeium").setup({
					enable_cmp_source = false,
					virtual_text = {
						enabled = true,
						key_bindings = {
							accept = "<Tab>",
							next = "<M-]>",
							prev = "<M-[>",
						},
					},
				})
			end,
		},
		{
			"tamton-aquib/duck.nvim",
			config = function()
				require("duck").setup({})
				vim.cmd("command! StartDuck lua require('duck').hatch()")
				vim.cmd("command! StopDuck lua require('duck').cook()")
			end,
		},
		{ import = "lazyvim.plugins.extras.linting.eslint" },
		{ import = "lazyvim.plugins.extras.formatting.prettier" },
		{ import = "lazyvim.plugins.extras.lang.typescript" },
		{ import = "lazyvim.plugins.extras.lang.json" },
		{ import = "lazyvim.plugins.extras.lang.tailwind" },
		{ import = "lazyvim.plugins.extras.util.mini-hipatterns" },
		{
			"glepnir/dashboard-nvim",
			config = function()
				require("dashboard").setup({
					-- Configure the dashboard options here
					-- Example configuration:
					theme = "default",
					config = {
						header = {
							"",
							"   __            __",
							"  / /__ __ ____ / /",
							" /  ' // // __// _ \\",
							"/_/_/_/\\_\\_\\  /_//_/",
							"",
						},
						center = {
							{
								icon = "  ",
								desc = "Recently latest session                  ",
								action = "SessionLoad",
							},
							{
								icon = "  ",
								desc = "Recently opened files                   ",
								action = "DashboardFindHistory",
							},
							{
								icon = "  ",
								desc = "Find File                               ",
								action = "Telescope find_files",
							},
							{
								icon = "  ",
								desc = "File Browser                            ",
								action = "Telescope file_browser",
							},
							{
								icon = "  ",
								desc = "Find word                               ",
								action = "Telescope live_grep",
							},
							{
								icon = "  ",
								desc = "Open Personal dotfiles                  ",
								action = "Telescope dotfiles path=" .. vim.fn.stdpath("config"),
							},
						},
						footer = { "Do one thing, do it well - Unix Philosophy" },
					},
				})
			end,
		},
		{
			"eandrju/cellular-automaton.nvim",
			config = function()
				vim.cmd("command! Rain CellularAutomaton make_it_rain")
			end,
		},
		{
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate",
			config = function()
				require("nvim-treesitter.configs").setup({
					ensure_installed = { "javascript", "tsx" },
					highlight = {
						enable = true,
						additional_vim_regex_highlighting = false,
					},
				})
			end,
		},
		{
			"tpope/vim-fugitive", -- Full Git wrapper for Neovim
			config = function()
				-- Fugitive doesn't require much setup; commands like :Git, :Gpush, :Gpull are available.
				vim.cmd([[
            nnoremap <leader>gs :Git status<CR>
            nnoremap <leader>gc :Git commit<CR>
            nnoremap <leader>gp :Git push<CR>
            nnoremap <leader>gl :Git pull<CR>
        ]])
			end,
		},
		{
			"lewis6991/gitsigns.nvim", -- Git integration for signs, blame, and more
			config = function()
				require("gitsigns").setup({
					signs = {
						add = { text = "+" },
						change = { text = "~" },
						delete = { text = "_" },
						topdelete = { text = "‾" },
						changedelete = { text = "~" },
					},
					on_attach = function(bufnr)
						local gs = package.loaded.gitsigns

						local function map(mode, l, r, opts)
							opts = opts or {}
							opts.buffer = bufnr
							vim.keymap.set(mode, l, r, opts)
						end

						-- Navigation
						map("n", "]c", function()
							if vim.wo.diff then
								return "]c"
							end
							vim.schedule(function()
								gs.next_hunk()
							end)
							return "<Ignore>"
						end, { expr = true })

						map("n", "[c", function()
							if vim.wo.diff then
								return "[c"
							end
							vim.schedule(function()
								gs.prev_hunk()
							end)
							return "<Ignore>"
						end, { expr = true })

						-- Actions
						map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
						map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
						map("n", "<leader>hS", gs.stage_buffer)
						map("n", "<leader>hu", gs.undo_stage_hunk)
						map("n", "<leader>hR", gs.reset_buffer)
						map("n", "<leader>hp", gs.preview_hunk)
						map("n", "<leader>hb", function()
							gs.blame_line({ full = true })
						end)
						map("n", "<leader>tb", gs.toggle_current_line_blame)
						map("n", "<leader>hd", gs.diffthis)
						map("n", "<leader>hD", function()
							gs.diffthis("~")
						end)
						map("n", "<leader>td", gs.toggle_deleted)
					end,
				})
			end,
		},
		{
			"allaman/emoji.nvim",
			config = function()
				require("emoji").setup({})
			end,
		},
		{ import = "plugins" },
	},
	defaults = {
		lazy = false,
		version = false,
	},
	dev = {
		path = "~/.ghq/github.com",
	},
	checker = { enabled = true },
	performance = {
		cache = {
			enabled = true,
		},
		rtp = {
			disabled_plugins = {
				"gzip",
				"netrwPlugin",
				"rplugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
	debug = false,
})
