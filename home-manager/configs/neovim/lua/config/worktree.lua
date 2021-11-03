require("git-worktree").setup({
  autopush = false,
})

local Worktree = require("git-worktree")

local function is_cdk(path)
  local found = path:find(vim.env["AWSCDK"], 1, true)

  print(found)
  return type(found) == "number" and found > 0
end

local M = {}

function M.yarn_test()
  local command = string.format(":silent !tmux-sender yarn test")
  vim.cmd(command)
end

function M.execute(path, just_build)
  if is_cdk(path) then
    local command = string.format(":silent !tmux-cdk tmux %s %s", path, just_build)
    vim.cmd(command)
  end

end

Worktree.on_tree_change(function(_ --[[op]], path, _ --[[upstream]])
  M.execute(path.path)
end)


return M
