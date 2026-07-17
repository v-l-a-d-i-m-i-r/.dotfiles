local todo_comments = require('todo-comments')
local assets = require('assets')

todo_comments.setup({
  keywords = {
    COMMENT = {
      icon = assets.comment_icons.comment,
      color = 'hint',
    },
  },
})
