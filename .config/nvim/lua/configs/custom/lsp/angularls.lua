local nvlsp = require "nvchad.configs.lspconfig"

-- Angular LSP Setup
-- Lê a versão do @angular/core do package.json do projeto
local function get_angular_core_version(project_root)
  if not project_root then
    return ""
  end

  local package_json = project_root .. "/package.json"
  if not vim.uv.fs_stat(package_json) then
    return ""
  end

  local file = io.open(package_json, "r")
  if not file then
    return ""
  end

  local contents = file:read "*a"
  file:close()

  local ok, json = pcall(vim.json.decode, contents)
  if not ok or not json.dependencies then
    return ""
  end

  local angular_core_version = json.dependencies["@angular/core"]
  if angular_core_version then
    angular_core_version = angular_core_version:match "%d+%.%d+%.%d+"
  end

  return angular_core_version or ""
end

-- Resolve o caminho do ngserver e os probe dirs a partir do root_dir do buffer.
-- Chamado quando o servidor está prestes a iniciar, não no startup do Neovim.
local function build_cmd(root_dir)
  local node_modules = root_dir and (root_dir .. "/node_modules") or nil

  -- Tenta ngserver global primeiro
  local ngserver_exe = vim.fn.exepath "ngserver"
  local ngserver_cmd = nil
  local extension_path = ""

  if #(ngserver_exe or "") > 0 then
    ngserver_cmd = ngserver_exe
    local real = vim.uv.fs_realpath(ngserver_exe)
    if real then
      extension_path = vim.fs.normalize(vim.fs.joinpath(vim.fs.dirname(real), "../../../"))
    end
  elseif node_modules then
    -- Usa ngserver local do projeto
    local local_ngserver = node_modules .. "/.bin/ngserver"
    if vim.uv.fs_stat(local_ngserver) then
      ngserver_cmd = local_ngserver
      extension_path = node_modules
    else
      -- Angular 17+: ngserver pode estar dentro de @angular/language-server
      local ng_ls_bin = node_modules .. "/@angular/language-server/bin/ngserver"
      if vim.uv.fs_stat(ng_ls_bin) then
        ngserver_cmd = ng_ls_bin
        extension_path = node_modules
      end
    end
  end

  if not ngserver_cmd then
    return nil
  end

  local probe_dir = node_modules or extension_path
  if probe_dir == "" then
    probe_dir = extension_path
  end

  local ts_probe_dirs = table.concat({ extension_path, probe_dir }, ",")
  local ng_probe_dirs = table.concat({
    vim.fs.joinpath(extension_path, "/@angular/language-server/node_modules"),
    vim.fs.joinpath(probe_dir, "/@angular/language-server/node_modules"),
  }, ",")

  local cmd = {
    ngserver_cmd,
    "--stdio",
    "--tsProbeLocations",
    ts_probe_dirs,
    "--ngProbeLocations",
    ng_probe_dirs,
  }

  local version = get_angular_core_version(root_dir)
  if version ~= "" then
    table.insert(cmd, "--angularCoreVersion")
    table.insert(cmd, version)
  end

  return cmd
end

return {
  -- cmd é uma função: executada quando o LSP vai iniciar para o buffer,
  -- recebendo o root_dir já resolvido. Isso evita o problema de getcwd() estático.
  cmd = function(dispatchers, config)
    local root_dir = config and config.root_dir or vim.fn.getcwd()
    local resolved_cmd = build_cmd(root_dir)
    if not resolved_cmd then
      vim.notify("[angularls] ngserver não encontrado em " .. tostring(root_dir), vim.log.levels.WARN)
      -- Retorna um objeto RPC "noop" para evitar erro no Neovim
      return {
        request = function(_, _, _, callback)
          if callback then
            callback("ngserver not found", nil)
          end
        end,
        notify = function() end,
        is_closing = function()
          return true
        end,
        terminate = function() end,
      }
    end
    return vim.lsp.rpc.start(resolved_cmd, dispatchers)
  end,
  filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx", "htmlangular" },
  root_markers = { "angular.json", "nx.json" },
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
  on_init = nvlsp.on_init,
}
