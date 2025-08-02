return {
  {
    'Kurama622/llm.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'MunifTanjim/nui.nvim' },
    cmd = { 'LLMSessionToggle', 'LLMSelectedTextHandler', 'LLMAppHandler' },
    config = function()
      local tools = require 'llm.tools'
      require('llm').setup {
        -- [[ Local LM Studio Models ]]
        url = 'http://localhost:1234/v1/completions',
        model = 'local-model',
        api_type = 'openai',
        max_tokens = 8000,
        temperature = 0.3,
        top_p = 0.7,

        prompt = 'You are a helpful german assistant.',

        spinner = {
          text = {
            '󰧞󰧞',
            '󰧞󰧞',
            '󰧞󰧞',
            '󰧞󰧞',
          },
          hl = 'Title',
        },

        prefix = {
          user = { text = '😃 ', hl = 'Title' },
          assistant = { text = '  ', hl = 'Added' },
        },

        -- history_path = "/tmp/llm-history",
        save_session = true,
        max_history = 15,
        max_history_name_length = 20,

        -- stylua: ignore
        keys = {
          -- The keyboard mapping for the input window.
          ["Input:Submit"]      = { mode = "n", key = "<cr>" },
          ["Input:Cancel"]      = { mode = {"n", "i"}, key = "<C-c>" },
          ["Input:Resend"]      = { mode = {"n", "i"}, key = "<C-r>" },

          -- only works when "save_session = true"
          ["Input:HistoryNext"] = { mode = {"n", "i"}, key = "<C-j>" },
          ["Input:HistoryPrev"] = { mode = {"n", "i"}, key = "<C-k>" },

          -- The keyboard mapping for the output window in "split" style.
          ["Output:Ask"]        = { mode = "n", key = "i" },
          ["Output:Cancel"]     = { mode = "n", key = "<C-c>" },
          ["Output:Resend"]     = { mode = "n", key = "<C-r>" },

          -- The keyboard mapping for the output and input windows in "float" style.
          ["Session:Toggle"]    = { mode = "n", key = "<leader>ac" },
          ["Session:Close"]     = { mode = "n", key = {"<esc>", "Q"} },
        },

        -- display diff [require by action_handler]
        display = {
          diff = {
            layout = 'vertical', -- vertical|horizontal split for default provider
            opts = { 'internal', 'filler', 'closeoff', 'algorithm:patience', 'followwrap', 'linematch:120' },
            provider = 'mini_diff', -- default|mini_diff
            disable_diagnostic = true, -- Whether to show diagnostic information when displaying diff
          },
        },
        app_handler = {
          -- Your AI tools Configuration
          -- TOOL_NAME = { ... }

          Completion = {
            handler = tools.completion_handler,
            opts = {
              url = 'http://localhost:1234/v1/completions',
              model = 'local-model',
              api_type = 'ollama',

              n_completions = 3,
              context_window = 512,
              max_tokens = 256,

              -- A mapping of filetype to true or false, to enable completion.
              filetypes = { sh = false },

              -- Whether to enable completion of not for filetypes not specifically listed above.
              default_filetype_enabled = true,

              auto_trigger = true,

              -- just trigger by { "@", ".", "(", "[", ":", " " } for `style = "nvim-cmp"`
              only_trigger_by_keywords = true,

              style = 'virtual_text', -- nvim-cmp or blink.cmp

              timeout = 10, -- max request time

              -- only send the request every x milliseconds, use 0 to disable throttle.
              throttle = 1000,
              -- debounce the request in x milliseconds, set to 0 to disable debounce
              debounce = 400,

              --------------------------------
              ---   just for virtual_text
              --------------------------------
              keymap = {
                virtual_text = {
                  accept = {
                    mode = 'i',
                    keys = '<C-a>',
                  },
                  next = {
                    mode = 'i',
                    keys = '<C-n>',
                  },
                  prev = {
                    mode = 'i',
                    keys = '<C-p>',
                  },
                  toggle = {
                    mode = 'n',
                    keys = '<leader>cp',
                  },
                },
              },
            },
          },
        },
      }
    end,
    keys = {
      { '<leader>ac', mode = 'n', '<cmd>LLMSessionToggle<cr>' },
      -- Your AI Tools Key mappings
      { '<leader>ts', mode = 'x', '<cmd>LLMAppHandler WordTranslate<cr>' },
      --    |                 |                             |
      -- your key mapping  your mode                    tool name
    },
  },
}
