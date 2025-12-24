return {
  {
    "sakhnik/nvim-gdb",
    event = "VeryLazy",

    config = function()
      -- Start GDB-session
      vim.keymap.set("n", "<leader>ds", ":GdbStart gdb -q %:r<CR>", { desc = "Start GDB" })
      vim.keymap.set("n", "<F5>", ":GdbStart gdb -q %:r<CR>", { desc = "Start GDB (F5)" })

      -- Run
      vim.keymap.set("n", "<leader>dr", ":GdbRun<CR>", { desc = "Run program" })

      -- Continue
      vim.keymap.set("n", "<leader>dc", ":GdbContinue<CR>", { desc = "Continue execution" })

      -- Toggle breakpoint
      vim.keymap.set("n", "<leader>db", ":GdbBreakpointToggle<CR>", { desc = "Toggle Breakpoint" })

      -- Quit GDB session
      vim.keymap.set("n", "<leader>dq", ":GdbStop<CR>", { desc = "Stop GDB session" })
    end
  }
}

