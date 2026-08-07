local notify = require("notify")

vim.notify = notify

vim.keymap.set("n", "<BS>", function()
    notify.dismiss({ pending = true, silent = true })
end, { desc = "Dismiss notifications", silent = true })
