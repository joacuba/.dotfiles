local utils = require("jc.plugins.utils")

vim.pack.add({
	{
		src = utils.gh("olimorris/codecompanion.nvim"),
		version = vim.version.range("^19.0.0"),
	},
	-- dependencies
	utils.gh("franco-ruggeri/codecompanion-spinner.nvim"),
	-- TODO: investigate about adding this dependency to codecompanion
	-- utils.gh("ravitemer/codecompanion-history.nvim")
})

-- setup codecompanion-spinner plugin, which provides a loading spinner for codecompanion
require("codecompanion-spinner").setup({})

require("codecompanion").setup({
	interactions = {
		chat = {
			adapter = "nvidia_nim",
		},
	},
	adapters = {
		-- see : h codecompanion-acp
		acp = {
			copilot = function()
				return require("codecompanion.adapters.acp.copilot_acp")
			end,
			opts = {
				-- only display the adapters defined in this config
				show_presets = false,
			},
		},
		http = {
			open_router = function()
				return require("codecompanion.adapters.http").extend("openai_compatible", {
					env = {
						url = "https://openrouter.ai/api",
						api_key = "OPENROUTER_API_KEY",
						chat_url = "/v1/chat/completions",
					},
					schema = {
						model = {
							default = "qwen/qwen3.6-plus-preview:free",
						},
					},
				})
			end,
			opts = {
				-- only display the adapters defined in this config
				show_presets = false,
			},
			nvidia_nim = function()
				-- 	return require("codecompanion.adapters.http").extend("openai", {
				-- 		name = "nvidia_nim",
				-- 		formatted_name = "Nvidia NIM",
				-- 		url = "https://integrate.api.nvidia.com/v1/chat/completions",
				-- 		env = {
				-- 			api_key = "NVIDIA-API-KEY",
				-- 		},
				-- 		headers = {
				-- 			["Content-Type"] = "application/json",
				-- 			["Authorization"] = "Bearer ${api_key}",
				-- 		},
				-- 		parameters = {
				-- 			sync = true,
				-- 		},
				-- 		schema = {
				-- 			model = {
				-- 				order = 1,
				-- 				mapping = "parameters",
				-- 				type = "enum",
				-- 				desc = "ID of the model to use",
				-- 				default = "moonshotai/kimi-k2.5",
				-- 				choices = {
				-- 					["moonshotai/kimi-k2.5"] = { opts = { can_reason = true, has_vision = true } },
				-- 					["z-ai/glm5"] = { opts = { can_reason = true } },
				-- 				},
				-- 			},
				-- 			max_tokens = {
				-- 				mapping = "parameters",
				-- 				default = 16384,
				-- 			},
				-- 		},
				-- 	})
				-- end,

				local openai = require("codecompanion.adapters.http.openai")
				return {
					name = "nvidia_nim",
					formatted_name = "Nvidia NIM",
					url = "https://integrate.api.nvidia.com/v1/chat/completions",
					env = {
						api_key = "NVIDIA_API_KEY",
					},
					-- new
					roles = openai.roles,
					opts = openai.opts,
					features = openai.features,
					--end
					headers = {
						["Content-Type"] = "application/json",
						["Authorization"] = "Bearer ${api_key}",
					},
					parameters = {
						sync = true,
					},
					handlers = {
						setup = function(self)
							if self.opts and self.opts.stream then
								self.parameters.stream = true
							end
							return true
						end,

						tokens = function(self, data)
							return openai.handlers.tokens(self, data)
						end,

						form_parameters = function(self, params, messages)
							return openai.handlers.form_parameters(self, params, messages)
						end,

						form_messages = function(self, messages)
							return openai.handlers.form_messages(self, messages)
						end,

						chat_output = function(self, data)
							return openai.handlers.chat_output(self, data)
						end,

						inline_output = function(self, data, context)
							return openai.handlers.inline_output(self, data, context)
						end,

						on_exit = function(self, data)
							return openai.handlers.on_exit(self, data)
						end,
					},
					schema = {
						model = {
							order = 1,
							mapping = "parameters",
							type = "enum",
							desc = "ID of the model to use",
							default = "moonshotai/kimi-k2.5",
							choices = {
								["moonshotai/kimi-k2.5"] = { opts = { can_reason = true, has_vision = true } },
								["z-ai/glm5"] = { opts = { can_reason = true } },
							},
						},
						max_tokens = {
							mapping = "parameters",
							default = 16384,
						},
					},
				}
			end,
		},
	},
	opts = {
		completion_provider = "cmp",
		extensions = {
			spinner = {},
		},
	},
})

vim.keymap.set("n", "<leader>cc", function()
	require("codecompanion").toggle({ window_opts = { width = 0.3 } })
end, { desc = "Toggle code companion chat" })

-- Visual mode: Append selection to the active chat
vim.keymap.set("v", "<leader>ca", "<cmd>CodeCompanionChat Add<CR>", { desc = "Add selection to CodeCompanion" })
vim.keymap.set(
	{ "n", "v" },
	"<C-a>",
	"<cmd>CodeCompanionActions<cr>",
	{ noremap = true, silent = true, desc = "CodeCompanion actions" }
)
