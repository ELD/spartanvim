return {
	"scalameta/nvim-metals",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"j-hui/fidget.nvim",
			opts = {},
		},
		{
			"mfussenegger/nvim-dap",
			config = function(self, opts)
				local dap = require("dap")

				dap.configurations.scala = {
					{
						type = "scala",
						request = "launch",
						name = "RunOrTest",
						metals = {
							runType = "runOrTestFile",
						},
						{
							type = "scala",
							request = "launch",
							metals = {
								runType = "testTarget",
							},
						},
					},
				}
			end,
		},
	},
	ft = { "scala", "sbt", "java" },
	----- Opts -----
	opts = function()
		local map = vim.keymap.set
		local lsp_custom = require("utils.lsp_customizations")
		local metals_config = require("metals").bare_config()
		metals_config.init_options.statusBarProvider = "off"
		metals_config.capabilities = lsp_custom.capabilities
		metals_config.settings.inlayHints = {
			hintsInPatternMatch = { enable = true },
			implicitArguments = { enable = true },
			implicitConversions = { enable = true },
			inferredTypes = { enable = true },
			typeParameters = { enable = true },
		}

		metals_config.on_attach = function(client, bufnr)
			require("metals").setup_dap()

			map("n", "<leader>ws", function()
				require("metals").hover_worksheet()
			end, { desc = "[Metals] Hover Worksheet" })
			map("n", "<leader>aa", vim.diagnostic.setqflist)

			-- all workspace errors
			map("n", "<leader>ae", function()
				vim.diagnostic.setqflist({ severity = "E" })
			end)

			-- all workspace warnings
			map("n", "<leader>aw", function()
				vim.diagnostic.setqflist({ severity = "W" })
			end)

			-- buffer diagnostics only
			map("n", "<leader>d", vim.diagnostic.setloclist)

			map("n", "[c", function()
				vim.diagnostic.goto_prev({ wrap = false })
			end)

			map("n", "]c", function()
				vim.diagnostic.goto_next({ wrap = false })
			end)

			-- Example mappings for usage with nvim-dap. If you don't use that, you can
			-- skip these
			map("n", "<leader>dc", function()
				require("dap").continue()
			end)

			map("n", "<leader>dr", function()
				require("dap").repl.toggle()
			end)

			map("n", "<leader>dK", function()
				require("dap.ui.widgets").hover()
			end)

			map("n", "<leader>dt", function()
				require("dap").toggle_breakpoint()
			end)

			map("n", "<leader>dso", function()
				require("dap").step_over()
			end)

			map("n", "<leader>dsi", function()
				require("dap").step_into()
			end)

			map("n", "<leader>dl", function()
				require("dap").run_last()
			end)

			lsp_custom.on_attach(client, bufnr)
		end

		return metals_config
	end,
	-------------- Config ----------------
	config = function(self, metals_config)
		local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
		vim.api.nvim_create_autocmd("FileType", {
			pattern = self.ft,
			callback = function()
				require("metals").initialize_or_attach(metals_config)
			end,
			group = nvim_metals_group,
		})
	end
}
