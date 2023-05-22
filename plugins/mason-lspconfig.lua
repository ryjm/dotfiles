-- use mason-lspconfig to configure LSP installations
return {
  "williamboman/mason-lspconfig.nvim",
  opts = {
    automatic_installation = true,
    ensure_installed = {
      "hoon_ls",
      "cssls",
      "html",
      "marksman",
      "jsonls",
      "pyright",
      "tsserver",
      "yamlls",
    },
  },
}
