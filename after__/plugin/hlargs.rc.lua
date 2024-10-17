local status, hlargs = pcall(require, 'hlargs')
if not status then
    print('hlargs is not installed.')
    return
end

hlargs.setup()
