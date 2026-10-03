local capabilities = require("lsp.handlers").capabilities

-- Applies to every server; nvim-lspconfig only supplies the default cmd/filetypes/root markers
vim.lsp.config("*", { capabilities = capabilities })

-- LUA
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})

-- Rust
vim.lsp.config("rust_analyzer", {
	on_attach = function(client, bufnr)
		require("lsp.handlers").on_attach(client, bufnr)
		-- vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
	end,
	settings = {
		["rust-analyzer"] = {
			diagnostics = {
				enable = true,
			},
			imports = {
				granularity = {
					group = "module",
				},
				prefix = "self",
			},
			cargo = {
				buildScripts = {
					enable = true,
				},
			},
			procMacro = {
				enable = true,
			},
		},
	},
})

-- Javascript/Typescript
local eslint_on_attach = vim.lsp.config.eslint.on_attach -- keeps lspconfig's LspEslintFixAll command
vim.lsp.config("eslint", {
	settings = {
		packageManager = "npm",
	},
	on_attach = function(client, bufnr)
		eslint_on_attach(client, bufnr)
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			command = "LspEslintFixAll",
		})
	end,
})

-- Auto-started servers. Others (pyright, lua_ls, bashls, html, cssls, dockerls,
-- docker_compose_language_service) are configured above/by default: start them with :LspStart <name>
vim.lsp.enable({
	"rust_analyzer",
	"clangd", -- C++
	"eslint",
	"lemminx", -- XML
	"vue_ls", -- VUE
})
