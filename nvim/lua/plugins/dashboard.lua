return {
	"nvimdev/dashboard-nvim",
	lazy = false,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local header_logo = {
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			"",
			[[             ★                   ✦                       ★                            ✧                     ]],
			[[                      ✧                       ★                 ✦                               ★           ]],
			[[         ✦                            ★                               ✧                                     ]],
			[[                            ★                       ✦                       ★                               ]],
			[[   ★                                        ✧                                             ✦                 ]],
			[[                   ✦                                        ★                                         ✧     ]],
			[[                                  ★                                   ✦                                     ]],
			[[       ★                                               ✧                           ★                        ]],
			[[                                                                                                   ✦        ]],
			[[                ★          ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗                           ]],
			[[                           ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║       ✦                   ]],
			[[         ✧                 ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║                 ★         ]],
			[[                    ★      ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║                           ]],
			[[    ✦                      ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║      ★             ✧      ]],
			[[                           ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝                           ]],
			[[                                                                                                            ]],
			[[         ★                              ✦                           ★                  ✧                    ]],
			[[                     ✦                                   ★                                            ✦     ]],
			[[          ✧                   ★                                ✦                   ★                        ]],
			[[                        ✧                      ★                               ✦                            ]],
			[[    ★                                                    ✧                                     ★            ]],
			[[                ★                       ✦                                 ★                                 ]],
			[[        ✦                       ★                   ✧                               ✦                       ]],
			[[                 ✧                                             ★                                  ✧         ]],
			"",
			"",
			"",
		}

		require("dashboard").setup({
			theme = "doom",
			config = {
				center = {
					{ icon = "    ", desc = "Plugin Manager ", action = "Lazy" },
					{ icon = "    ", desc = "LSP Manager ", action = "Mason" },
					{ icon = "    ", desc = "Config         ", action = "e ~/.config/nvim/init.lua" },
				},
				header = header_logo,
				footer = function()
					local version = "Neovim v"
						.. vim.version().major
						.. "."
						.. vim.version().minor
						.. "."
						.. vim.version().patch
					local stats = require("lazy").stats()
					local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
					return {
						"",
						"",
						"",
						"⚡ Startuptime: "
							.. ms
							.. " ms  |  "
							.. version
							.. "  |  Plugins: "
							.. stats.count
							.. " installed",
					}
				end,
			},
		})
	end,
}
