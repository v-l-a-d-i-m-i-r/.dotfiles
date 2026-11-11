---
name: reflect
description: Session retrospective. Lists what went wrong or took extra time, and proposes minimal edits to the context files that guide the agent. Use when the user asks for it at the end of a session.
---

1. Review this session and list what went wrong: tool calls denied by the user, extra steps, unclear briefs, agent errors. Use only events you can see in this session. Propose only what really happened. Do not propose edits "just in case".
   - "Extra time" means a retry, a correction from the user, or a repeated tool call.
   - If the history is summarized, say so. List only visible events.
   - If nothing went wrong, say so. Propose no edits.
2. Find the context files that guided the agent in this session: instructions, prompts, skills, agent definitions, known-issues notes, and other such files.
3. For each item, propose one minimal edit to one file that would prevent it next time. Use one file per item. Show all items in one table with these columns: No., Problem, File, Before, After.
   - Write `(none)` in Before for a new line.
4. Do not change anything until the user approves. Ask the user to approve by item number.
5. After approval, apply the edit.
