local status, transparent = pcall(require, 'transparent')
if not status then
    print('transparent.nvim is not installed.')
    return
end

transparent.setup({ })
