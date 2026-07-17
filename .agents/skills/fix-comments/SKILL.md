---
name: fix-comments
description: Implement changes described in comments
argument-hint: "[revision]"
---

Find all comments containing the keyword `COMMENT:` (using whatever comment syntax the file's language uses) and implement what each one describes.

Scope of files to search:
- If `$1` (a commit hash, branch, or HEAD-relative ref) is given, search the diff against that revision.
- Otherwise, search staged, unstaged, and untracked changes.

If a change is too complex or unclear, ask the user.

Process one comment at a time:
1. Implement the change described.
2. Show the user the diff you made for that comment and ask for review.
3. If the user approves, remove the `COMMENT:` comment and move to the next one.
4. If the user rejects it, leave the comment in place, retry the implementation based on their feedback, and ask again.
