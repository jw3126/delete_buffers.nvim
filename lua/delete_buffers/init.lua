local M = {}
M.config = {}

function M.setup(cfg)
    M.config = cfg
    return M
end

local function get_hidden_buffers()
    local ret = {}
    local buffer_hide_table = {}
    for _,buf in pairs(vim.api.nvim_list_bufs()) do
        buffer_hide_table[buf] = true
    end
    for _,win in pairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        buffer_hide_table[buf] = false
    end
    for buf, ishidden in pairs(buffer_hide_table) do
        if ishidden then
            ret[#ret+1] = buf
        end
    end
    return ret
end

function M.delete_hidden_buffers()
    local bufs = get_hidden_buffers()
    for _,buf in pairs(bufs) do
        local cmd = "bd " .. buf
        pcall(vim.cmd, cmd)
    end
end

return M
