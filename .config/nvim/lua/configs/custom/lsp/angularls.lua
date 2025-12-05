local nvlsp = require "nvchad.configs.lspconfig"
-- Angular LSP Setup
-- Helper para encontrar root dir
local function find_root(patterns)
  return vim.fs.dirname(vim.fs.find(patterns, { upward = true })[1])
end

local function setup()
  local root_dir = vim.fn.getcwd()
  local node_modules_dir = vim.fs.find("node_modules", { path = root_dir, upward = true })[1]
  local project_root = node_modules_dir and vim.fs.dirname(node_modules_dir) or nil

  local function get_probe_dir()
    return project_root and (project_root .. "/node_modules") or ""
  end

  local function get_angular_core_version()
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

  local default_probe_dir = get_probe_dir()
  local default_angular_core_version = get_angular_core_version()

  -- Encontra o caminho do ngserver
  local ngserver_exe = vim.fn.exepath "ngserver"
  local extension_path = ""
  local ngserver_cmd = nil

  if #(ngserver_exe or "") > 0 then
    -- ngserver global encontrado
    ngserver_cmd = ngserver_exe
    local ngserver_path = vim.fs.dirname(vim.uv.fs_realpath(ngserver_exe))
    extension_path = vim.fs.normalize(vim.fs.joinpath(ngserver_path, "../../../"))
  elseif project_root then
    -- Tenta usar ngserver local do projeto
    local local_ngserver = project_root .. "/node_modules/.bin/ngserver"
    if vim.uv.fs_stat(local_ngserver) then
      ngserver_cmd = local_ngserver
      extension_path = project_root .. "/node_modules"
    end
  end

  -- Se não encontrou ngserver, retorna nil para desabilitar
  if not ngserver_cmd then
    vim.notify("angularls: ngserver not found. Install @angular/language-server", vim.log.levels.WARN)
    return nil
  end

  -- Fallback para extension_path se ainda não encontrou
  if extension_path == "" and default_probe_dir ~= "" then
    extension_path = default_probe_dir
  end

  local ts_probe_dirs = table.concat({ extension_path, default_probe_dir }, ",")
  local ng_probe_dirs = table.concat({
    vim.fs.joinpath(extension_path, "/@angular/language-server/node_modules"),
    vim.fs.joinpath(default_probe_dir, "/@angular/language-server/node_modules"),
  }, ",")

  local cmd = {
    ngserver_cmd,
    "--stdio",
    "--tsProbeLocations",
    ts_probe_dirs,
    "--ngProbeLocations",
    ng_probe_dirs,
  }

  -- Adiciona versão do Angular Core se encontrada
  if default_angular_core_version ~= "" then
    table.insert(cmd, "--angularCoreVersion")
    table.insert(cmd, default_angular_core_version)
  end

  return {
    cmd = cmd,
    filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx", "htmlangular" },
    root_dir = find_root { "angular.json", "nx.json", "package.json" },
    on_attach = nvlsp.on_attach,
    capabilities = nvlsp.capabilities,
    on_init = nvlsp.on_init,
  }
end

return {
  setup = setup,
}
