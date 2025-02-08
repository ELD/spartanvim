vim.filetype.add({
	extension = {
		["http"] = "http",
	},
	filename = {
		[".env"] = "sh",
		[".envrc"] = "sh",
		["*.env"] = "sh",
		["*.envrc"] = "sh",
	},
})
