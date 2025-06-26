return {
  {
    dir = "~/projects/plugins/chtsht",
    config = function()
      require("chtsht").setup()
    end
  },
  {
    dir = "~/projects/plugins/runner",
    config = function()
      -- require("runner").setup()
    end
  }
}
