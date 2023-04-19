local status_nullls, null_ls = pcall(require, "null-ls") 
local status_package, mason_package = pcall(require, "mason-core.package")
local status_registory, mason_registry = pcall(require, "mason-registry")

if not status_nullls then
    print('null-ls is not installed.')
    return
end
if not status_package then
    print('mason-core is not installed.')
    return
end
if not status_registory then
    print('mason-registry is not installed.')
    return
end

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

local sources = {
    null_ls.builtins.diagnostics.shellcheck.with({
        diagnostic_config = {
            -- see :help vim.diagnostic.config()
            underline = true,
            virtual_text = false,
            signs = true,
            update_in_insert = true,
            severity_sort = true,
        },
    }),
}

null_sources['sources'] = sources

null_ls.setup({
    sources = null_sources,
})

