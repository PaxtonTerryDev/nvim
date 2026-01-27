import("neovim/nvim-lspconfig")
import("sigmaSd/deno-nvim")
require("plugins.mason")


vim.lsp.config('denols', {
  on_attach = on_attach,
  root_markers = { "deno.json", "deno.jsonc" },
})

vim.lsp.config('ts_ls', {
  on_attach = on_attach,
  root_markers = { "package.json" },
  single_file_support = false,
})

vim.lsp.config('eslint', {
  on_attach = on_attach,
  root_markers = { ".eslintrc", ".eslintrc.js", ".eslintrc.json", ".eslintrc.cjs", "eslint.config.js", "eslint.config.mjs", "package.json" },
})


vim.lsp.enable({
  "eslint",
  "ts_ls",
  "denols",
  'lua_ls',
  'jsonls',
  'gopls',
  'rust_analyzer',
  'prismals',
  'marksman'
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or "n"
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end

    map("<leader>ln", vim.lsp.buf.rename, "change symbol name")
    map("<leader>la", vim.lsp.buf.code_action, "execute code action", { "n", "x" })
    map("<leader>lr", require("telescope.builtin").lsp_references, "find references")
    map("<leader>li", require("telescope.builtin").lsp_implementations, "find implementations")
    map("<leader>ld", vim.lsp.buf.definition, "go to definition")
    map("<leader>lD", vim.lsp.buf.declaration, "go to declaration")
    map("<leader>lO", require("telescope.builtin").lsp_document_symbols, "open document symbols")
    map(
      "<leader>lW",
      require("telescope.builtin").lsp_dynamic_workspace_symbols,
      "open workspace symbols"
    )
    map("<leader>lt", require("telescope.builtin").lsp_type_definitions, "go to type definition")
    map("<leader>lf", function() vim.lsp.buf.format({ async = true }) end, "format document")
    map("<leader>lh", vim.lsp.buf.hover, "hover documentation")
    map("<leader>le", vim.diagnostic.open_float, "show diagnostics")

    -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
    ---@param client vim.lsp.Client
    ---@param method vim.lsp.protocol.Method
    ---@param bufnr? integer some lsp support methods only in specific files
    ---@return boolean
    local function client_supports_method(client, method, bufnr)
      if vim.fn.has("nvim-0.11") == 1 then
        return client:supports_method(method, bufnr)
      else
        return client.supports_method(method, { bufnr = bufnr })
      end
    end

    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    See `:help CursorHold` for information about when this is executed
    --
    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if
        client
        and client_supports_method(
          client,
          vim.lsp.protocol.Methods.textDocument_documentHighlight,
          event.buf
        )
    then
      local highlight_augroup =
          vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
        end,
      })
    end

    -- The following code creates a keymap to toggle inlay hints in your
    -- code, if the language server you are using supports them
    --
    -- This may be unwanted, since they displace some of your code
    if
        client
        and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
    then
      map("<leader>lth", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
      end, "toggle inline hints")
    end
  end,
})
