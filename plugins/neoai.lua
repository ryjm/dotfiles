return {
  "Bryley/neoai.nvim",
  lazy = false,
  enabled = true,
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  cmd = {
    "NeoAI",
    "NeoAIOpen",
    "NeoAIClose",
    "NeoAIToggle",
    "NeoAIContext",
    "NeoAIContextOpen",
    "NeoAIContextClose",
    "NeoAIInject",
    "NeoAIInjectCode",
    "NeoAIInjectContext",
    "NeoAIInjectContextCode",
  },
  keys = {
    { "<leader>as", desc = "summarize text" },
    { "<leader>at", desc = "fix text with AI" },
    { "<leader>ao", desc = "open" },
    { "<leader>ac", desc = "generate code" },
    { "<leader>ag", desc = "generate git message" },
  },
  config = function()
    require("neoai").setup {
      -- Below are the default options, feel free to override what you would like changed
      ui = {
        output_popup_text = "neoai",
        input_popup_text = "prompt",
        width = 30, -- as percentage eg. 30%
        output_popup_height = 80, -- as percentage eg. 80%
        submit = "<enter>", -- Key binding to submit the prompt
      },
      models = {
        {
          name = "openai",
          model = "gpt-4",
          params = nil,
        },
      },
      register_output = {
        ["g"] = function(output) return output end,
        ["c"] = require("neoai.utils").extract_code_snippets,
      },
      inject = {
        cutoff_width = 75,
      },
      prompts = {
        context_prompt = function(context)
          return "Hey, I'd like to provide some context for future "
            .. "messages. Here is the code/text that I want to refer "
            .. "to in our upcoming conversations:\n\n"
            .. context
        end,
      },
      mappings = {
        ["select_up"] = "<C-k>",
        ["select_down"] = "<C-j>",
      },
      open_api_key_env = "OPEN_AI_KEY",
      shortcuts = {
        {
          name = "similar_code",
          key = "<leader>sc",
          desc = "generate similar code",
          use_context = true,
          prompt = function() return "Produce code similar to the style of the provided context." end,
          modes = { "v" },
          strip_function = nil,
        },

        {
          name = "translate",
          key = "<leader>ar",
          desc = "translate text with AI",
          use_context = true,
          prompt = function()
            return "Translate the following text to Spanish if it's in English, otherwise to spanish:"
          end,
          modes = { "v" },
          strip_function = nil,
        },

        {
          name = "open",
          modes = { "n" },
          key = "<leader>ao",
          desc = "set a new prompt",
          use_context = false,
          prompt = [[
            directives:
              - only respond in code blocks
              - be as concise as possible
              - the code should be terse but readable
          ]],
          strip_function = function(output) return "" end,
        },
        {
          name = "code",
          modes = { "v" },
          key = "<leader>ac",
          desc = "generate code",
          use_context = true,
          prompt = function()
            return "Generate code based on the provided description for " .. "the language " .. vim.bo.filetype
          end,
        },
        {
          name = "summarize",
          key = "<leader>as",
          desc = "summarize text",
          use_context = true,
          prompt = [[
                Please summarize the following text into a short summary
                that is 75 characters or less:
            ]],
          modes = { "v" },
          strip_function = nil,
        },
        {
          name = "textify",
          key = "<leader>at",
          desc = "fix text with AI",
          use_context = true,
          prompt = [[
                Please rewrite the text to make it more readable, clear,
                concise, and fix any grammatical, punctuation, or spelling
                errors
            ]],
          modes = { "v" },
          strip_function = nil,
        },
        {
          name = "gitcommit",
          key = "<leader>ag",
          desc = "generate git commit message",
          use_context = false,
          prompt = function()
            return [[
                    Using the following git diff generate a consise and
                    clear git commit message, with a short title summary
                    that is 75 characters or less:
                ]] .. vim.fn.system "git diff --cached"
          end,
          modes = { "n" },
          strip_function = nil,
        },
      },
    }
  end,
}
