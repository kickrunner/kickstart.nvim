local jdtls = require('jdtls')

local root_dir = jdtls.setup.find_root({'.git', 'pom.xml', 'build.gradle', 'mvnw', 'gradlew' })
if not root_dir then
  return
end
local project_name = vim.fn.fnamemodify(root_dir:gsub('/$', ''), ':t')
local workspace_dir = vim.fs.joinpath(vim.fn.stdpath('cache'), 'jdtls/workspace/', project_name)
local jdtls_dir = vim.fs.joinpath(vim.fn.stdpath 'data', 'mason/packages/jdtls')

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {

    -- 💀
    vim.fs.normalize '~/.sdkman/candidates/java/current/bin/java', -- or '/path/to/java21_or_newer/bin/java'
    -- depends on if `java` is in your $PATH env variable and if it points to the right version.

    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-noverify',
    '-Xmx4G',
    '-XX:+UseG1GC',
    '-XX:+UseStringDeduplication',
    '-javaagent:' .. vim.fs.normalize '~/.m2/repository/org/projectlombok/lombok/1.18.30/lombok-1.18.30.jar',
    '--add-modules=ALL-SYSTEM',
    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',

    -- 💀
    '-jar',
    vim.fn.glob(vim.fs.joinpath(jdtls_dir, 'plugins/org.eclipse.equinox.launcher_*.jar')),
    -- ^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
    -- Must point to the                                                     Glob finds the
    -- eclipse.jdt.ls installation                                           correct version automatically

    -- 💀
    '-configuration',
    vim.fs.joinpath(jdtls_dir, 'config_' .. (vim.fn.has 'macunix' == 1 and 'mac' or 'linux')),
    -- ^^^^^^^^^^^^^^^^^^^        ^^^^^^
    -- Must point to the                      Change to one of `linux`, `win` or `mac`
    -- eclipse.jdt.ls installation            Depending on your system.

    -- 💀
    -- See `data directory configuration` section in the README
    '-data',
    workspace_dir,
  },

  -- 💀
  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  --
  -- vim.fs.root requires Neovim 0.10.
  -- If you're using an earlier version, use: require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
  root_dir = root_dir,

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {},
  },

  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  init_options = {
    bundles = {},
  },
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)

