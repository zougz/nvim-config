return {
    "mfussenegger/nvim-lint",
    event = "BufWritePost",
    config = function()
        require("lint").linters_by_ft = {
            cpp = { "cpplint" },
            c = { "cpplint" },
        }
        vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
            callback = function()
                require("lint").try_lint()
            end,
        })
    end,
}
