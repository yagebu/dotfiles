-- vim: set foldmethod=marker:
-- Directories {{{
vim.opt.backupdir:remove({ "." })
-- create backup dir if it doesn't exist
local backup_dir = vim.opt.backupdir:get()[1]
if not vim.fn.isdirectory(backup_dir) then
  vim.fn.mkdir(backup_dir, "p")
end
-- disable netrw for nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- }}}
-- Documentation and overview {{{
-- Some helpful references
--  - an example initial config file with modern nvim plugins:
--    https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
-- }}}
-- Pre-plugin basic configuration {{{
-- enable 24 bit colors
vim.opt.termguicolors = true
-- enable mouse support in [a]ll modes
vim.opt.mouse = "a"
-- Sync clipboard between OS and Neovim.
vim.opt.clipboard = "unnamedplus"

-- set this explicitly for performance
vim.g.python3_host_prog = "/usr/bin/python3"
-- disable these explicitly for performance
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- as recommended by vim-stay:
vim.opt.viewoptions = { "cursor", "folds", "slash", "unix" }

-- vim-sleuth is used for auto-detection of tabs and spaces settings

vim.opt.number = true
vim.opt.undofile = true

vim.opt.scrolloff = 4

-- case-insensitive search
vim.opt.ignorecase = true
-- uppercase causes case-sensitive search
vim.opt.smartcase = true
-- apply substitutions globally by default
vim.opt.gdefault = true
vim.opt.inccommand = "split"

-- set this before plugins to ensure that they use the correct one
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- }}}
-- Plugins {{{
-- setup vim-plug automatically if not installed yet {{{
vim.cmd([[
if empty(glob($XDG_DATA_HOME . '/nvim/site/autoload/plug.vim'))
    silent !echo "Installing vim-plug..."
    silent !curl -fLo $XDG_DATA_HOME/nvim/site/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    augroup plug_install
        autocmd!
        autocmd VimEnter * PlugInstall
    augroup END
endif

call plug#begin($XDG_DATA_HOME . '/nvim/plugged')
" }}}
" Lua library needed by other plugins.
Plug 'nvim-lua/plenary.nvim'

" Automatically detect tabs/spaces
Plug 'tpope/vim-sleuth'

" Preview copy/paste registers
Plug 'junegunn/vim-peekaboo'

Plug 'justinmk/vim-sneak'

Plug 'Konfekt/FastFold'
" Automatically save editor state
Plug 'zhimsel/vim-stay'
" Undotree, opens with `U`.
Plug 'mbbill/undotree'
" Color CSS variables.
Plug 'NvChad/nvim-colorizer.lua'
" Fuzzy finder
Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
" File tree (mapped to `T`)
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdateSync'}
" Allows using <C-a> and <C-x> on dates like `2012-12-12`
Plug 'tpope/vim-speeddating'
Plug 'vim-test/vim-test'
" Show Keymappings
Plug 'folke/which-key.nvim'
" Highlight TODO comments
Plug 'folke/todo-comments.nvim'
" A collection of various mini plugins. Currently used ones see below.
" https://github.com/echasnovski/mini.nvim
Plug 'echasnovski/mini.nvim'
" git {{{
" were never really used, so disabled / removed for now
" Plug 'jreybert/vimagit'
" Plug 'junegunn/gv.vim'
" Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'
" }}}
" Language server and linting {{{
Plug 'neovim/nvim-lspconfig'
Plug 'nvimtools/none-ls.nvim'
Plug 'folke/trouble.nvim'
" }}}
" Autocompletion {{{
Plug 'hrsh7th/nvim-cmp'

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
" }}}
" File type specific plugins {{{
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'ledger/vim-ledger', { 'for': 'beancount' }
Plug 'lervag/vimtex'
Plug 'nathangrigg/vim-beancount', { 'for': 'beancount' }
Plug 'mrcjkb/rustaceanvim', { 'tag': '*' }
" }}}
" Color schemes {{{
Plug 'ellisonleao/gruvbox.nvim'
" Plug 'morhetz/gruvbox'
" }}}
call plug#end()
]])
-- }}}
-- nvim-treesitter {{{
local nvim_treesitter_configs = require("nvim-treesitter.configs")
nvim_treesitter_configs.setup({
  ensure_installed = {
    "bash",
    "css",
    "html",
    "javascript",
    "json",
    "lua",
    "rust",
    "svelte",
    "typescript",
    "vim",
  },
  highlight = {
    enable = true,
  },
})
-- }}}
-- Colorscheme gruvbox {{{
-- set colorscheme
vim.cmd.colorscheme("gruvbox")
-- }}}
-- Initialise misc plugins (colorizer, mini.{align,comment,surround,statusline}, todo-comments, which-key) {{{
-- colorizer colors CSS colors
require("colorizer").setup()
require("mini.align").setup()
require("mini.comment").setup()
require("mini.surround").setup()
require("mini.statusline").setup({ use_icons = false })

require("todo-comments").setup()

vim.opt.timeout = true
vim.opt.timeoutlen = 300
require("which-key").setup()
require("which-key").register({
  ["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
  ["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
  ["<leader>h"] = { name = "Git [H]unk", _ = "which_key_ignore" },
  ["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
  ["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
  ["<leader>t"] = { name = "[T]est", _ = "which_key_ignore" },
  ["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
})
require("which-key").register({
  ["<leader>h"] = { "Git [H]unk" },
}, { mode = "v" })
-- }}}
-- gitsigns {{{
-- keybindings taken from
-- https://github.com/nvim-lua/kickstart.nvim/blob/master/lua/kickstart/plugins/gitsigns.lua
require("gitsigns").setup({
  on_attach = function(bufnr)
    local gitsigns = require("gitsigns")

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map("n", "]c", function()
      if vim.wo.diff then
        vim.cmd.normal({ "]c", bang = true })
      else
        gitsigns.nav_hunk("next")
      end
    end, { desc = "Jump to next git [c]hange" })

    map("n", "[c", function()
      if vim.wo.diff then
        vim.cmd.normal({ "[c", bang = true })
      else
        gitsigns.nav_hunk("prev")
      end
    end, { desc = "Jump to previous git [c]hange" })

    -- Actions
    -- visual mode
    map("v", "<leader>hs", function()
      gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, { desc = "stage git hunk" })
    map("v", "<leader>hr", function()
      gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, { desc = "reset git hunk" })
    -- normal mode
    map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "git [s]tage hunk" })
    map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "git [r]eset hunk" })
    map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "git [S]tage buffer" })
    map("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "git [u]ndo stage hunk" })
    map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "git [R]eset buffer" })
    map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "git [p]review hunk" })
    map("n", "<leader>hb", gitsigns.blame_line, { desc = "git [b]lame line" })
    map("n", "<leader>hd", gitsigns.diffthis, { desc = "git [d]iff against index" })
    map("n", "<leader>hD", function()
      gitsigns.diffthis("@")
    end, { desc = "git [D]iff against last commit" })
    -- Toggles
    map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "[T]oggle git show [b]lame line" })
    map("n", "<leader>tD", gitsigns.toggle_deleted, { desc = "[T]oggle git show [D]eleted" })
  end,
})
-- }}}
-- nvim-tree {{{
local nvim_tree = require("nvim-tree")
local nvim_tree_api = require("nvim-tree.api")

nvim_tree.setup({
  diagnostics = {
    enable = true,
  },
  update_focused_file = {
    enable = true,
  },
  renderer = {
    icons = {
      show = {
        file = false,
        folder = false,
        folder_arrow = false,
      },
      git_placement = "after",
    },
  },
})
-- }}}
-- nvim-lspconfig {{{
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local lspconfig = require("lspconfig")

-- Keymappings mostly as recommended in
-- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua#L457
-- which is quite close to
-- https://github.com/neovim/nvim-lspconfig#suggested-configuration
-- but adds descriptions and uses telescope in more places
--
-- The formatting is overwritten to not use the tsserver for formatting.
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(event)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[event.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
    vim.lsp.inlay_hint.enable()

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end
    map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
    map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
    map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
    map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
    map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
    map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
    map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
    map("K", vim.lsp.buf.hover, "Hover Documentation")
    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    map("<leader>f", function()
      vim.lsp.buf.format({
        async = true,
        filter = function(client) -- this is the only modification from the suggested defaults
          return client.name ~= "tsserver"
        end,
      })
    end, "[F]ormat buffer")
  end,
})

local capabilities = cmp_nvim_lsp.default_capabilities()
local lsp_setup_args = { capabilities = capabilities }

lspconfig.tsserver.setup(lsp_setup_args)
lspconfig.svelte.setup(lsp_setup_args)
lspconfig.eslint.setup(lsp_setup_args)
lspconfig.pylsp.setup(lsp_setup_args)
lspconfig.ruff_lsp.setup(lsp_setup_args)
-- rust_analyzer is setup automatically by rustaceanvim

-- TODO: inlay hints should work again with neovim 0.10
vim.g.rustaceanvim = {
  ---@type RustaceanLspClientOpts
  server = {
    default_settings = {
      ["rust-analyzer"] = {
        cargo = {
          extraEnv = {
            -- to work around https://github.com/PyO3/pyo3/issues/1708
            CARGO_TARGET_DIR = "target/rust-analyzer",
          },
        },
        checkOnSave = {
          command = "clippy",
        },
      },
    },
  },
}
-- }}}
-- null-ls (extra linters and formatters) {{{
local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    -- Javascript, Typescript, Svelte, etc.
    -- eslint is handled by language server
    null_ls.builtins.formatting.prettier.with({ extra_filetypes = { "svelte" } }),

    -- CSS
    null_ls.builtins.diagnostics.stylelint.with({ extra_filetypes = { "svelte" } }),

    -- Shell
    -- indent with 4 spaces
    null_ls.builtins.formatting.shfmt.with({ extra_args = { "-i", "4" } }),

    -- Lua
    -- indent with 2 spaces
    null_ls.builtins.formatting.stylua.with({ extra_args = { "--indent-type", "Spaces", "--indent-width", "2" } }),

    -- Python
    -- ruff is handled by language server
    -- only run diagnostics on save with mypy since it's not very performant
    null_ls.builtins.diagnostics.mypy.with({ method = null_ls.methods.DIAGNOSTICS_ON_SAVE }),
    -- using ruff now instead of black
    -- null_ls.builtins.formatting.black,
  },
})
-- }}}
-- trouble (diagnostics interface) {{{
local trouble = require("trouble")
trouble.setup({ icons = false })
-- }}}
-- Key bindings {{{
-- Folds and exiting insert mode.
vim.keymap.set({ "n", "v" }, "<space><space>", "za")
vim.keymap.set("", "<Tab>", "%")
-- Save one keystroke for commmands
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode with jk" })
-- Save and quit
vim.keymap.set("i", "<C-S>", "<C-O>:update<CR>")
vim.keymap.set("n", "<C-S>", ":update<CR>")
vim.keymap.set("i", "<C-Q>", "<Esc>:q<CR>")
vim.keymap.set("n", "<C-Q>", ":q<CR>")
-- Move up/down by on-screen lines
vim.keymap.set({ "n", "v" }, "j", "gj")
vim.keymap.set({ "n", "v" }, "k", "gk")
vim.keymap.set({ "n", "v" }, "gj", "j")
vim.keymap.set({ "n", "v" }, "gk", "k")
-- Buffers
vim.keymap.set("n", "]b", ":bnext<CR>", { silent = true })
vim.keymap.set("n", "[b", ":bprev<CR>", { silent = true })
-- Tabs
vim.keymap.set("n", "]t", ":tabn<CR>", { silent = true })
vim.keymap.set("n", "[t", ":tabp<CR>", { silent = true })
-- Quicker window navigation
vim.keymap.set("n", "<C-H>", "<C-W>h")
vim.keymap.set("n", "<C-J>", "<C-W>j")
vim.keymap.set("n", "<C-K>", "<C-W>k")
vim.keymap.set("n", "<C-L>", "<C-W>l")
vim.keymap.set("n", "<BS>", "<C-W>h", { remap = true })
-- Terminal mappings
vim.keymap.set("t", "<C-H>", "<C-\\><C-n><C-W>h")
vim.keymap.set("t", "<C-J>", "<C-\\><C-n><C-W>j")
vim.keymap.set("t", "<C-K>", "<C-\\><C-n><C-W>k")
vim.keymap.set("t", "<C-L>", "<C-\\><C-n><C-W>l")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
-- MISC other plugin commands
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "T", nvim_tree_api.tree.toggle, { silent = true })
vim.keymap.set("n", "U", ":UndotreeToggle<CR>", { silent = true })

-- Fuzzy file search
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader><leader>", builtin.find_files, { desc = "[  ] Search files" })
-- the following are taken from kickstart.nvim
vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
-- vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

vim.keymap.set({ "n", "x" }, "ga", "<Plug>(EasyAlign)")
-- Run tests
vim.keymap.set("n", "<leader>tn", ":TestNearest<CR>", { desc = "[T]est [n]earest" })
vim.keymap.set("n", "<leader>tf", ":TestFile<CR>", { desc = "[T]est [f]ile" })
vim.keymap.set("n", "<leader>ta", ":TestSuite<CR>", { desc = "[T]est [a]ll tests" })
-- }}}
-- Completion {{{
local cmp = require("cmp")

vim.g.UltiSnipsSnippetDirectories = { vim.env.HOME .. "/dev/dotfiles/snippets" }
vim.g.UltiSnipsExpandTrigger = "<C-J>"
vim.g.UltiSnipsJumpForwardTrigger = "<C-J>"
vim.g.UltiSnipsJumpBackwardTrigger = "<C-K>"

vim.opt.completeopt = { "menu", "menuone", "noselect" }

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ["<Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    ["<S-Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "ultisnips" },
  }, {
    { name = "buffer" },
  }),
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})
-- }}}
-- Automatically run make on nvim_init changes {{{
local group_id = vim.api.nvim_create_augroup("yagebu_nvim_init", {})
vim.api.nvim_create_autocmd("BufWritePost", {
  desc = "Automatically copy over new dotfiles on changes.",
  pattern = "*/dev/dotfiles/*",
  command = "silent !make -C ~/dev/dotfiles > /dev/null",
  group = group_id,
})
-- }}}
-- TODO: write a lua function for this. Is useful to sort Beancount transactions {{{
-- function! SortParagraphs() range
--     execute a:firstline . ',' . a:lastline . 'd'
--     let @@=join(sort(split(substitute(@@, '\n*$', '', ''), "\n\n")), "\n\n")
--     put!
-- endfunction
-- }}}
-- File types {{{
-- Fold configuration {{{
vim.api.nvim_create_autocmd("FileType", {
  desc = "Use nvim_treesitter to get folds",
  pattern = {
    "rust",
    "sh",
    "zsh",
    "python",
    "svelte",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
  },
  command = "setlocal foldmethod=expr foldexpr=nvim_treesitter#foldexpr()",
  group = group_id,
})
-- }}}
-- Mail {{{
vim.api.nvim_create_autocmd("FileType", {
  desc = "Set formatoptions for emails",
  pattern = "mail",
  command = "setlocal formatoptions+=aw",
  group = group_id,
})
-- }}}
-- Latex {{{
-- Better syntax hightlighting
vim.g.tex_flavor = "latex"

vim.g.vimtex_compiler_method = "tectonic"
vim.g.vimtex_compiler_tectonic = {
  build_dir = vim.env.HOME .. "/.cache/latex-build",
}
vim.g.vimtex_fold_enabled = 1
vim.g.vimtex_motion_enabled = 1
vim.g.vimtex_matchparen_enabled = 0

vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_compiler_progname = "nvr"
vim.g.vimtex_imaps_list = {}

vim.api.nvim_create_autocmd("User", {
  desc = "Enable latex compilation",
  pattern = "VimtexEventInitPost",
  command = "VimtexCompile",
  group = group_id,
})
-- }}}
-- Beancount (with custom org-mode folding) {{{
vim.cmd([[
function! BeancountFold(lnum)
    let l1 = getline(a:lnum)
    if l1 =~# '^*'
        return '>'.match(l1, '[^*]')
    endif
    return '='
endfunction
]])
vim.api.nvim_create_autocmd("FileType", {
  desc = "Beancount specific config",
  pattern = "beancount",
  command = "setlocal foldmethod=expr foldexpr=BeancountFold(v:lnum)",
  group = group_id,
})
vim.api.nvim_create_autocmd("FileType", {
  desc = "Beancount specific config",
  pattern = "beancount",
  command = "SpeedDatingFormat %Y-%m",
  group = group_id,
})
-- TODO: these need to be buffer-local
vim.api.nvim_create_autocmd("FileType", {
  desc = "Beancount specific config",
  pattern = "beancount",
  callback = function(args)
    local opts = { noremap = true, buffer = args.buf }
    vim.keymap.set("i", ".", ".<C-\\><C-O>:AlignCommodity<CR>", opts)
  end,
  group = group_id,
})
vim.api.nvim_create_autocmd("FileType", {
  desc = "Beancount specific config",
  pattern = "beancount",
  callback = function(args)
    local opts = { noremap = true, buffer = args.buf }
    vim.keymap.set("n", "<leader>t", ":call ledger#transaction_state_toggle(line('.'), '*!')<CR>", opts)
  end,
  group = group_id,
})
-- }}}
-- }}}
