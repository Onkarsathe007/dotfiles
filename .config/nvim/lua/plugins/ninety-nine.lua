return {
    {
        "ThePrimeagen/99",
        config = function()
            local _99 = require("99")
            local cwd = vim.uv.cwd()
            local basename = vim.fs.basename(cwd)

            _99.setup({
                model = "opencode/glm-4.7-free",
                logger = {
                    level = _99.DEBUG,
                    path = "/tmp/" .. basename .. ".99.debug",
                    print_on_error = true,
                },
                completion = {
                    custom_rules = {
                        "~/.config/nvim/skills/",
                    },
                    source = "cmp",
                },

                md_files = {
                    "AGENT.md",
                },
            })

            -- Fill in function
            vim.keymap.set("n", "<leader>9f", function()
                _99.fill_in_function()
            end, { desc = "99: Fill in function" })

            -- Visual selection AI
            vim.keymap.set("v", "<leader>9v", function()
                _99.visual()
            end, { desc = "99: Visual AI" })

            -- Fill in function with prompt
            vim.keymap.set("n", "<leader>9p", function()
                _99.fill_in_function_prompt()
            end, { desc = "99: Fill in function with prompt" })

            -- Visual with prompt
            vim.keymap.set("v", "<leader>9s", function()
                _99.visual_prompt()
            end, { desc = "99: Visual with prompt" })

            -- Stop all requests
            vim.keymap.set("n", "<leader>9x", function()
                _99.stop_all_requests()
            end, { desc = "99: Stop all requests" })

            -- View logs
            vim.keymap.set("n", "<leader>9l", function()
                _99.view_logs()
            end, { desc = "99: View logs" })

            -- View request history
            vim.keymap.set("n", "<leader>9h", function()
                _99.previous_requests_to_qfix()
            end, { desc = "99: Request history" })

            -- View 99 info
            vim.keymap.set("n", "<leader>9i", function()
                _99.info()
            end, { desc = "99: Info" })

            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
                callback = function()
                    local bufnr = vim.api.nvim_get_current_buf()
                    local ns = vim.api.nvim_create_namespace("99_skills")

                    vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

                    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

                    for lnum, line in ipairs(lines) do
                        for skill in line:gmatch("@%w+") do
                            local start_col = line:find(skill, 1, true) - 1
                            local end_col = start_col + #skill

                            vim.api.nvim_buf_add_highlight(bufnr, ns, "TSVariable", lnum - 1, start_col, end_col)
                        end
                    end
                end,
            })
        end,
    },
}
