return {
    {
        "zbirenbaum/copilot.lua",
        -- lazy load: when you enter insert mode, or when :Copilot command is used
        event = "InsertEnter",
        cmd = "Copilot",
        config = function()
            require("copilot").setup({
                suggestion = {
                    enabled = true,    -- we let copilot-cmp show suggestions instead
                    auto_trigger = true,
                    keymap = {
                        accept = "<C-l>",    -- accept suggestion
                        accept_word = "<C-j>",
                        accept_line = "<C-k>",
                        next = "<C-]>",
                        prev = "<C-[>",
                        dismiss = "<C-h>",
                    },
                },
                panel = {
                    enabled = false,
                },
                -- optionally restrict filetypes (you might only want math / tex / markdown etc)
                filetypes = {
                    -- for example, disable it in gitcommit:
                    gitcommit = false,
                    help = false,
                    -- you can explicitly enable for tex, markdown, etc
                    latex = true,
                    python = true,
                },
            })
            vim.keymap.set('n', '<leader>ct', function()
                local ok_client, client = pcall(require, "copilot.client")
                local ok_cmd, cmd = pcall(require, "copilot.command")
                if not (ok_client and ok_cmd) then
                    print("Copilot not loaded yet")
                    return
                end

                if client.is_disabled() then
                    cmd.enable()
                    print("Copilot Enabled")
                else
                    cmd.disable()
                    print("Copilot Disabled")
                end
            end, { desc = "Toggle Copilot" })
        end,
    },
}
