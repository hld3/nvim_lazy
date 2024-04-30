-- Don't forget to install jdtls using Mason
local java_config = {
	cmd = { vim.fn.expand("~/.local/share/nvim/mason/bin/jdtls") },
	root_dir = vim.fs.dirname(vim.fs.find({ 'src', 'gradlew', 'mvnw' }, { upward = true })[1]),
}
require('jdtls').start_or_attach(java_config)
