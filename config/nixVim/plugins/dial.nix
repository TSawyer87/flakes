{pkgs, ...}: {
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [dial-nvim];
    extraConfigLua = ''
            local dial = {
      	"monaqa/dial.nvim",
      	keys = {
      		{ "<C-a>", mode = "n", desc = "Increment" },
      		{ "<C-x>", mode = "n", desc = "Decrement" },
      		{ "<C-a>", mode = "v", desc = "Increment" },
      		{ "<C-x>", mode = "v", desc = "Decrement" },
      		{ "g<C-a>", mode = "v", desc = "G increment" },
      		{ "g<C-x>", mode = "v", desc = "G decrement" },
      	},
      	config = function()
      		local augend = require("dial.augend")
      		require("dial.config").augends:register_group({
      			-- default augends used when no group name is specified
      			default = {
      				augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
      				augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
      				augend.integer.alias.octal,
      				augend.integer.alias.binary,
      				augend.constant.alias.bool,
      				augend.constant.alias.alpha,
      				augend.constant.alias.Alpha,
      				augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
      				augend.constant.new({
      					elements = { "and", "or" },
      					word = true, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
      					cyclic = true, -- "or" is incremented into "and".
      				}),
      				augend.constant.new({
      					elements = { "min", "max" },
      					word = true,
      					cyclic = true,
      				}),
      				augend.constant.new({
      					elements = { "True", "False" },
      					word = true,
      					cyclic = true,
      				}),
      				augend.constant.new({
      					elements = { "true", "false" },
      					word = true,
      					cyclic = true,
      				}),
      				augend.constant.new({
      					elements = { "lower", "upper" },
      					word = false,
      					cyclic = true,
      				}),
      				augend.constant.new({
      					elements = { "&&", "||" },
      					word = false,
      					cyclic = true,
      				}),
      				augend.constant.new({
      					elements = { "&", "|" },
      					word = false,
      					cyclic = true,
      				}),
      				augend.constant.new({
      					elements = { "+", "-" },
      					word = false,
      					cyclic = true,
      				}),
      				augend.constant.new({
      					elements = { "++", "--" },
      					word = false,
      					cyclic = true,
      				}),
      				augend.constant.new({
      					elements = { ">>", "<<" },
      					word = false,
      					cyclic = true,
      				}),
      				augend.constant.new({
      					elements = { ">", "<" },
      					word = false,
      					cyclic = true,
      				}),
      				augend.hexcolor.new({
      					case = "lower",
      				}),
      				augend.hexcolor.new({
      					case = "upper",
      				}),
      			},
      		})

      		map("n", "<C-a>", require("dial.map").inc_normal(), { noremap = true })
      		map("n", "<C-x>", require("dial.map").dec_normal(), { noremap = true })
      		map("v", "<C-a>", require("dial.map").inc_visual(), { noremap = true })
      		map("v", "<C-x>", require("dial.map").dec_visual(), { noremap = true })
      		map("v", "g<C-a>", require("dial.map").inc_gvisual(), { noremap = true })
      		map("v", "g<C-x>", require("dial.map").dec_gvisual(), { noremap = true })
      	end,
      }
    '';
  };
}
