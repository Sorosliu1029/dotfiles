-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local jdtls = require("jdtls")
local globals = require("core.globals")
local consts = require("core.consts")

local p_sep = globals.path.sep
local mason_path = consts.dirs.nvim_data .. p_sep .. "mason" .. p_sep .. "packages"
local jdtls_path = mason_path .. p_sep .. "jdtls"
local jdtls_jar_path = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
local configuration_path = jdtls_path .. "/config_" .. (globals.sys.is_mac and "mac" or "linux") .. (globals.sys.is_arm and "_arm" or "")

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = consts.dirs.home .. "/.cache/jdtls/workspace/" .. project_name

local config = {
  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew" }),

  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {

    "java", -- or '/path/to/java21_or_newer/bin/java'
    -- depends on if `java` is in your $PATH env variable and if it points to the right version.

    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xmx1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-javaagent:" .. jdtls_path .. "/lombok.jar",

    "-jar",
    jdtls_jar_path,
    -- "/path/to/jdtls_install_location/plugins/org.eclipse.equinox.launcher_VERSION_NUMBER.jar",
    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
    -- Must point to the                                                     Change this to
    -- eclipse.jdt.ls installation                                           the actual version

    "-configuration",
    configuration_path,
    -- "/path/to/jdtls_install_location/config_SYSTEM",
    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
    -- Must point to the                      Change to one of `linux`, `win` or `mac`
    -- eclipse.jdt.ls installation            Depending on your system.

    -- See `data directory configuration` section in the README
    "-data",
    workspace_dir,
    -- "/path/to/unique/per/project/workspace/folder",
  },

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
      signatureHelp = { enabled = true },
      extendedClientCapabilities = jdtls.extendedClientCapabilities,
      import = { enabled = true },
      rename = { enabled = true },
      contentProvider = { preferred = "fernflower" }, -- Use fernflower to decompile library code
      maven = {
        downloadSources = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      -- Specify any completion options
      completion = {
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*",
        },
        filteredTypes = {
          "com.sun.*",
          "io.micrometer.shaded.*",
          "java.awt.*",
          "jdk.*",
          "sun.*",
        },
      },
      -- Specify any options for organizing imports
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      -- How code generation should act
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
        },
        hashCodeEquals = {
          useJava7Objects = true,
        },
        useBlocks = true,
      },
    },
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
  -- on_init = function(client)
  --   if client.config.settings then
  --     client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
  --   end
  -- end,
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
jdtls.start_or_attach(config)
