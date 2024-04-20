-- vim: set foldmethod=marker:
-- Directories {{{
vim.opt.backupdir:remove({ "." })
if vim.fn.isdirectory(vim.o.backupdir) then
  vim.fn.mkdir(vim.o.backupdir, "p")
end
-- disable netrw for nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- }}}
-- Plugins {{{
-- setup {{{
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
Plug 'Konfekt/FastFold'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-oblique'
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/vim-pseudocl'
Plug 'justinmk/vim-sneak'
Plug 'kopischke/vim-stay'
Plug 'mbbill/undotree'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdateSync'}
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'vim-test/vim-test'
" git {{{
Plug 'jreybert/vimagit'
Plug 'junegunn/gv.vim'
Plug 'tpope/vim-fugitive'
" }}}
" Language server {{{
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
Plug 'morhetz/gruvbox'
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
-- Basic settings {{{
vim.o.termguicolors = true
vim.o.mouse = "a"

vim.cmd("colorscheme gruvbox")
local colorizer = require("colorizer")
colorizer.setup()

vim.g.python3_host_prog = "/usr/bin/python3"
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- Do not use tabs and use 4 spaces for indentation
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.expandtab = true

-- as recommended by vim-stay:
vim.o.viewoptions = "cursor,folds,slash,unix"

vim.o.number = true
vim.o.undofile = true

vim.o.scrolloff = 4

vim.o.ignorecase = true -- case-insensitive search
vim.o.smartcase = true -- uppercase causes case-sensitive search
vim.o.gdefault = true -- apply substitutions globally by default
vim.o.inccommand = "split"
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
-- https://github.com/neovim/nvim-lspconfig#suggested-configuration
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set("n", "<space>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<space>f", function()
      vim.lsp.buf.format({
        async = true,
        filter = function(client) -- this is the only modification from the suggested defaults
          return client.name ~= "tsserver"
        end,
      })
    end, opts)
  end,
})

local capabilities = cmp_nvim_lsp.default_capabilities()
local lsp_setup_args = { capabilities = capabilities }

lspconfig.tsserver.setup(lsp_setup_args)
lspconfig.svelte.setup(lsp_setup_args)
lspconfig.eslint.setup(lsp_setup_args)
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
    null_ls.builtins.formatting.prettier.with({
      extra_filetypes = { "svelte" },
    }),

    -- CSS
    null_ls.builtins.diagnostics.stylelint.with({
      extra_filetypes = { "svelte" },
    }),

    -- Shell
    null_ls.builtins.formatting.shfmt.with({
      -- indent with 4 spaces
      extra_args = { "-i", "4" },
    }),

    null_ls.builtins.formatting.stylua.with({
      -- indent with 2 spaces
      extra_args = { "--indent-type", "Spaces", "--indent-width", "2" },
    }),

    -- Python
    -- ruff is handled by language server
    null_ls.builtins.diagnostics.mypy.with({
      method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
    }),
    -- null_ls.builtins.formatting.black,
  },
})
-- }}}
-- trouble (diagnostics interface) {{{
local trouble = require("trouble")
trouble.setup({
  icons = false,
})
-- }}}
-- Key bindings {{{
vim.g.mapleader = ";"
-- Folds and exiting insert mode.
vim.keymap.set({ "n", "v" }, "<space><space>", "za", { noremap = true })
vim.keymap.set("", "<Tab>", "%", { noremap = true })
-- Save one keystroke for commmands
vim.keymap.set("i", "jk", "<Esc>", { noremap = true })
-- Save and quit
vim.keymap.set("i", "<C-S>", "<C-O>:update<CR>", { noremap = true })
vim.keymap.set("n", "<C-S>", ":update<CR>", { noremap = true })
vim.keymap.set("i", "<C-Q>", "<Esc>:q<CR>", { noremap = true })
vim.keymap.set("n", "<C-Q>", ":q<CR>", { noremap = true })
-- Move up/down by on-screen lines
vim.keymap.set({ "n", "v" }, "j", "gj", { noremap = true })
vim.keymap.set({ "n", "v" }, "k", "gk", { noremap = true })
vim.keymap.set({ "n", "v" }, "gj", "j", { noremap = true })
vim.keymap.set({ "n", "v" }, "gk", "k", { noremap = true })
-- Buffers
vim.keymap.set("n", "]b", ":bnext<CR>", { silent = true })
vim.keymap.set("n", "[b", ":bprev<CR>", { silent = true })
-- Tabs
vim.keymap.set("n", "]t", ":tabn<CR>", { silent = true })
vim.keymap.set("n", "[t", ":tabp<CR>", { silent = true })
-- Quicker window navigation
vim.keymap.set("n", "<C-H>", "<C-W>h", { noremap = true })
vim.keymap.set("n", "<C-J>", "<C-W>j", { noremap = true })
vim.keymap.set("n", "<C-K>", "<C-W>k", { noremap = true })
vim.keymap.set("n", "<C-L>", "<C-W>l", { noremap = true })
vim.keymap.set("n", "<BS>", "<C-W>h", { remap = true })
-- Terminal mappings
vim.keymap.set("t", "<C-H>", "<C-\\><C-n><C-W>h", { noremap = true })
vim.keymap.set("t", "<C-J>", "<C-\\><C-n><C-W>j", { noremap = true })
vim.keymap.set("t", "<C-K>", "<C-\\><C-n><C-W>k", { noremap = true })
vim.keymap.set("t", "<C-L>", "<C-\\><C-n><C-W>l", { noremap = true })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true })
-- Fuzzy file search and MISC other plugin commands
vim.keymap.set("n", "<leader><space>", ":nohlsearch<CR>", { silent = true })
vim.keymap.set("n", "T", nvim_tree_api.tree.toggle, { silent = true })
vim.keymap.set("n", "U", ":UndotreeToggle<CR>", { silent = true })
-- vim.keymap.set('n', '<leader><leader>', ':Files<CR>', { silent = true })
-- vim.keymap.set('n', '<leader>b', ':Buffers<CR>', { silent = true })
-- vim.keymap.set('n', '<leader>h', ':Helptags<CR>', { silent = true })
-- vim.keymap.set('n', '<leader>r', ':Rg<CR>', { silent = true })
local telescope_builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader><leader>", telescope_builtin.find_files, {})
vim.keymap.set("n", "<leader>b", telescope_builtin.buffers, {})
vim.keymap.set("n", "<leader>h", telescope_builtin.help_tags, {})
vim.keymap.set("n", "<leader>r", telescope_builtin.live_grep, {})

vim.keymap.set({ "n", "x" }, "ga", "<Plug>(EasyAlign)")
-- Run tests
vim.keymap.set("n", "t<C-n>", ":TestNearest<CR>", { silent = true })
vim.keymap.set("n", "t<C-f>", ":TestFile<CR>", { silent = true })
vim.keymap.set("n", "t<C-s>", ":TestSuite<CR>", { silent = true })
vim.keymap.set("n", "t<C-l>", ":TestLast<CR>", { silent = true })
vim.keymap.set("n", "t<C-g>", ":TestVisit<CR>", { silent = true })
-- }}}
-- Completion {{{
local cmp = require("cmp")

vim.g.UltiSnipsSnippetDirectories = { vim.env.HOME .. "/dev/dotfiles/snippets" }
vim.g.UltiSnipsExpandTrigger = "<C-J>"
vim.g.UltiSnipsJumpForwardTrigger = "<C-J>"
vim.g.UltiSnipsJumpBackwardTrigger = "<C-K>"

vim.o.completeopt = "menu,menuone,noselect"

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
-- Misc {{{
local group_id = vim.api.nvim_create_augroup("yagebu_nvim_init", {})
vim.api.nvim_create_autocmd("BufWritePost", {
  desc = "Automatically copy over new dotfiles on changes.",
  pattern = "*/dev/dotfiles/*",
  command = "silent !make -C ~/dev/dotfiles > /dev/null",
  group = group_id,
})

-- TODO: write a lua function for this. Is useful to sort Beancount transactions.
-- function! SortParagraphs() range
--     execute a:firstline . ',' . a:lastline . 'd'
--     let @@=join(sort(split(substitute(@@, '\n*$', '', ''), "\n\n")), "\n\n")
--     put!
-- endfunction
-- }}}
-- Terminal colors {{{
-- dark0 + gray
vim.g.terminal_color_0 = "#282828"
vim.g.terminal_color_8 = "#928374"
-- neutral_red + bright_red
vim.g.terminal_color_1 = "#cc241d"
vim.g.terminal_color_9 = "#fb4934"
-- neutral_green + bright_green
vim.g.terminal_color_2 = "#98971a"
vim.g.terminal_color_10 = "#b8bb26"
-- neutral_yellow + bright_yellow
vim.g.terminal_color_3 = "#d79921"
vim.g.terminal_color_11 = "#fabd2f"
-- neutral_blue + bright_blue
vim.g.terminal_color_4 = "#458588"
vim.g.terminal_color_12 = "#83a598"
-- neutral_purple + bright_purple
vim.g.terminal_color_5 = "#b16286"
vim.g.terminal_color_13 = "#d3869b"
-- neutral_aqua + faded_aqua
vim.g.terminal_color_6 = "#689d6a"
vim.g.terminal_color_14 = "#8ec07c"
-- light4 + light1
vim.g.terminal_color_7 = "#a89984"
vim.g.terminal_color_15 = "#ebdbb2"
-- }}}
-- Lightline {{{
vim.o.laststatus = 2
vim.g.lightline = {
  colorscheme = "gruvbox",
  active = {
    left = {
      { "mode", "paste" },
      { "readonly", "filename", "modified", "gitbranch" },
    },
  },
  component_function = {
    gitbranch = "FugitiveHead",
  },
}
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
-- 2 spaces indentation {{{
vim.api.nvim_create_autocmd("FileType", {
  desc = "2 spaces for indentation",
  pattern = {
    "svelte",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "css",
    "scss",
    "html",
    "jinja",
    "jinja.html",
    "c",
    "lua",
  },
  command = "setlocal shiftwidth=2 softtabstop=2",
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
