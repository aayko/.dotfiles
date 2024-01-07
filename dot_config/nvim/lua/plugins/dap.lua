return {
    'mfussenegger/nvim-dap',
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "folke/neodev.nvim"
    },
    config = function()
        require("neodev").setup({
            library = { plugins = { "nvim-dap-ui" }, types = true },
        })

        require("dapui").setup()

        local dap = require("dap")
        dap.adapters.gdb = {
            type = "executable",
            command = "gdb",
            args = { "-i", "dap" }
        }

        local dap = require("dap")
        dap.configurations.c = {
            {
                name = "Launch",
                type = "gdb",
                request = "launch",
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = "${workspaceFolder}",
            },
        }
    end
}
