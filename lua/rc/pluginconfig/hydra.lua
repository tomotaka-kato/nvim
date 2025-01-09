local hydra = require('hydra')
hydra({
    name = 'window resize',
    mode = 'n',
    body = '<C-w>',
    heads = {
        { 'h', '<C-w><' },
        { 'l', '<C-w>>' },
        { 'j', '<C-w>-' },
        { 'k', '<C-w>+' },
        { 'H', '5<C-w><' },
        { 'L', '5<C-w>>' },
        { 'J', '5<C-w>-' },
        { 'K', '5<C-w>+' }
    }
})
