require("diffview").setup({
  hooks = {
    view_opened = function (view)
       print(
                      ("A new %s was opened on tab page %d!")
                      :format(view:class():name(), view.tabpage)
                    )
    end,
  },
})
