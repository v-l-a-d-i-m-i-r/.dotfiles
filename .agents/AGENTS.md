# Agent Instructions

## Language

- Write all output text in ASD-STE100 Simplified Technical English.
- Use the ubiquitous language from `CONTEXT.md` if this file is in the project.

## Code Style and Conventions

- **Analyze First:** Before writing or modifying code, always analyze the surrounding files to identify the project's established conventions.
- **Adhere to Existing Patterns:** Rigorously follow the conventions you identify, including:
  - Folder structure and file naming.
  - Indentation style (tabs vs. spaces, and size).
  - Naming conventions (e.g., camelCase, snake_case).
  - Bracket and brace positioning.
  - Function argument style (positional vs. objects).
  - Quote style (single vs. double).
- **Use Project Tooling:** If the project has a linter (like ESLint) or a formatter (like Prettier), prioritize using them. Run the linter/formatter to ensure your changes automatically conform to the project's defined style.

## Verification

- After making code changes, you must attempt to verify them.
- Proactively search the project for verification methods (e.g., build scripts, tests, linters).
- Check `package.json`, `README.md`, or other configuration files for commands like `build`, `test`, `lint`, or `verify`.
- Execute the discovered verification commands to ensure your changes are correct and have not introduced any issues.

## Core Rules

### Simplicity First

- Prefer the simplest working solution.
- Avoid unnecessary abstractions.
- Do not introduce new patterns unless clearly justified.

### Respect Existing Code

- Follow the current project structure and style.
- Do not rewrite unrelated code.
- Do not rename variables or functions without a clear reason.

### Dependencies

- Do NOT add external libraries unless explicitly requested.
- Prefer built-in APIs and existing dependencies.

## Git

- Never use `cd` in a command that also has `git`, even with `git -C`. This always asks for permission.
- Do not use `cd` to run commands. Use absolute paths: `git -C /abs/path log`, `ls /abs/path`.
- Run each command alone. Do not chain with `;` or `&&` if not needed.

## Negative Rules (What Not To Do)

- Do NOT over-engineer or add unnecessary complexity.
- Do NOT add comments that explain obvious code; focus on the "why," not the "what."
- Do NOT generate excessive explanations in your responses.
- Do NOT assume requirements that are not specified.
- Do NOT modify parts of the codebase unrelated to the task.

## Testing Requirements

- When adding a new feature, add tests that verify its correctness.
- When fixing a bug, add a test that reproduces the bug and proves the fix.
- Always include tests for edge cases and potential failure scenarios.

## Node.js Version & Package Manager Management

- Run `node`, `yarn`, `npm`, `pnpm`, and `npx` only as `~/.bin/nvmx <command>`, in the session directory.
- Choose the package manager from the lock file: `pnpm-lock.yaml` for `pnpm`, `yarn.lock` for `yarn`, `package-lock.json` or no lock file for `npm`.
- Examples: `~/.bin/nvmx node -v`, `~/.bin/nvmx yarn test`, `~/.bin/nvmx npx tsc --noEmit`.

## Code Intelligence

Prefer LSP over Grep/Glob/Read for code navigation:

- `goToDefinition` / `goToImplementation` to jump to source
- `findReferences` to see all usages across the codebase
- `workspaceSymbol` to find where something is defined
- `documentSymbol` to list all symbols in a file
- `hover` for type info without reading the file
- `incomingCalls` / `outgoingCalls` for call hierarchy

Before renaming or changing a function signature, use `findReferences` to find all call sites first.
Use Grep/Glob only for text/pattern searches (comments, strings, config values) where LSP doesn't help.
After writing or editing code, check LSP diagnostics before moving on. Fix any type errors or missing imports immediately.

## File Editing

- Use the Edit or Write tool for all file changes.
- Use the Write tool to create files. It creates missing parent directories.
- Do NOT use `touch`, `mkdir`, `python`, `sed`, `awk`, `tee`, or heredocs to create or change files.
- The Write tool has no separate "create" command. Write creates a new file.
- Write makes the parent directories. mkdir is not necessary.
- Write to an existing file needs a prior Read.

## Response Formatting & Style

- **Zero Preamble:** Do not use introductory phrases, pleasantries, or acknowledgments (e.g., "Certainly," "I understand," or "Here is...").
- **Brevity:** Deliver the minimum amount of text required for a complete answer. Strictly avoid "fluff" or redundant context.
- **Structural Priority:** Use **Markdown tables** and **bulleted lists** as the default format. Avoid paragraphs longer than two sentences.
- **No Unsolicited Explanations:** Provide results only. Do not explain the logic, background, or reasoning unless explicitly requested with phrases like "Explain" or "Why".
- **Minimalist Code:** Provide only the essential code requested. Use 2-space indentation (except for Go, which uses tabs).
- **No Post-amble:** Do not include summaries, tips, or follow-up suggestions at the end of the response.
