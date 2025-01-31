return {
	"ckipp01/nvim-jenkinsfile-linter",
	config = function()
		vim.keymap.set("n", "<leader>jv", function()
			require("jenkinsfile_linter").validate()
		end, { silent = true, desc = "Validate Jenkinsfile" })
	end,
}
