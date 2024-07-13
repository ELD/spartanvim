local M = {}

-- Method for setting LSP keymaps when attaching to a language server
--- @param client table
--- @param bufnr number
--- @return nil
--- @diagnostic disable-next-line: unused-local
local function lsp_keymaps(client, bufnr)
	local keymap = function(mode, key, action, desc)
		vim.keymap.set(mode, key, action, { desc = desc, buffer = bufnr })
	end

	keymap("n", "gD", vim.lsp.buf.definition, "Go to definition")
	keymap("n", "K", vim.lsp.buf.hover)
	keymap("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
	keymap("n", "gr", vim.lsp.buf.references, "Go to references")
	keymap("n", "gds", vim.lsp.buf.document_symbol, "Document symbols")
	keymap("n", "gws", vim.lsp.buf.workspace_symbol, "Workspace symbols")
	keymap("n", "gd", vim.lsp.buf.declaration, "Go to declaration")
	keymap("n", "<leader>cl", vim.lsp.codelens.run, "Run Codelens")
	keymap("n", "<leader>sn", vim.lsp.buf.signature_help, "Go to signature")
	keymap("n", "<leader>rn", vim.lsp.buf.rename, "Refactor: Rename")
	keymap({ "n", "x" }, "<leader>rf", vim.lsp.buf.format, "Refactor: format")

	keymap("n", "gtd", vim.lsp.buf.type_definition, "Go to type declaration")
	keymap("n", "<M-Enter>", vim.lsp.buf.code_action, "Code Action")

	-- TODO: Add more lspsaga keybinds
	keymap("n", "<leader>sf", ":Lspsaga finder<CR>", "Lspsaga: Launch finder")
	keymap("n", "<leader>si", ":Lspsaga incoming_calls<CR>", "Lspsaga: Incoming calls")
	keymap("n", "<leader>so", ":Lspsaga outgoing_calls<CR>", "Lspsaga: Outgoing calls")
end

--- Setting any special highlights for language servers that support it
--- @param client table
--- @param bufnr number
--- @return nil
local function lsp_highlight_document(client, bufnr)
	if client.server_capabilities.documentHighlightProvider then
		vim.api.nvim_create_augroup("lsp_document_highlight", {
			clear = false,
		})
		vim.api.nvim_clear_autocmds({
			buffer = bufnr,
			group = "lsp_document_highlight",
		})
		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			group = "lsp_document_highlight",
			buffer = bufnr,
			callback = vim.lsp.buf.document_highlight,
		})
		vim.api.nvim_create_autocmd("CursorMoved", {
			group = "lsp_document_highlight",
			buffer = bufnr,
			callback = vim.lsp.buf.clear_references,
		})
	end
end

--- Checks the Neovim version and enables inlay hints using the built-in methods or via the language server, if it
--- supports it
--- @param client table
--- @param bufnr number
--- @return nil
local function enable_inlay_hints(client, bufnr)
	if vim.lsp.inlay_hint and client.supports_method("textDocument/inlayHint") then
		vim.lsp.inlay_hint.enable(true)
	end
end

--- A customized `on_attach` method for configuring language servers
--- @param client table
--- @param bufnr number
--- @return nil
M.on_attach = function(client, bufnr)
	lsp_keymaps(client, bufnr)
	lsp_highlight_document(client, bufnr)
	enable_inlay_hints(client, bufnr)
end

--- Noop function
--- @return nil
M.noop = function() end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_nvim_lsp = require("cmp_nvim_lsp")

local cmp_capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

cmp_capabilities.textDocument.semanticHighlighting = true
cmp_capabilities.offsetEncoding = "utf-8"
cmp_capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFOldingOnly = true,
}

M.capabilities = cmp_capabilities

return M
