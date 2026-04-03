local M = {}

-- Helper function to construct GitHub URLs for repositories
-- @param repo The GitHub repository in the format "owner/repo"
-- @return The full GitHub URL for the repository
---@param repo string
---@return string
function M.gh(repo)
	return "https://github.com/" .. repo
end

return M
