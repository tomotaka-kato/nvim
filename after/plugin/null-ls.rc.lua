local status_nullls, null_ls = pcall(require, "null-ls") 
local status_package, mason_package = pcall(require, "mason-core.package")
local status_registory, mason_registry = pcall(require, "mason-registry")

if not status_nullls then return end
if not status_package then return end
if not status_registory then return end

local null_sources = {}

for _, package in ipairs(mason_registry.get_installed_packages()) do
    local package_categories = package.spec.categories[1]
    if package_categories == mason_package.Cat.Formatter then
        table.insert(null_sources, null_ls.builtins.formatting[package.name])
    end
    if package_categories == mason_package.Cat.Linter then
        table.insert(null_sources, null_ls.builtins.diagnostics[package.name])
    end
end

null_ls.setup({
    sources = null_sources,
})

