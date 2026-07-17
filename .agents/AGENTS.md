# Agent Instructions

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

## Output Format (Strict)
When a request requires me to write or modify code, I must respond using this exact structure. For simple questions not involving code, a direct, conversational answer is acceptable.

### Plan
- A high-level, step-by-step plan of the actions I will take. This should be a clear and concise sequence of operations I will perform to accomplish the goal.

### Code
- The complete and final code required to implement the plan.
- **No placeholders:** The code must be complete. I will not use placeholders like `// ...` or `// unchanged` to omit code.
- **Provide context:** When modifying existing code, I will provide enough surrounding context to be unambiguous.

### Notes
- Key decisions, trade-offs, and important context behind my implementation. This section explains the "why" of my approach, not just the "what."

### Verification
- A description of the steps I took to verify my changes are correct.
- **Commands:** I will list the exact commands I ran (e.g., `npm test`, `go build`).
- **Outcome:** I will state the outcome of the verification (e.g., "All tests passed," "Build successful").
- **Manual Check:** If no automated verification was possible, I will describe the manual check I performed and what I observed.

### Edge Cases
- A list of potential edge cases, failure modes, or unusual inputs that I considered during implementation and how the code handles them.

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
- **Node.js Version Policy:** When executing `npm`, `yarn`, `pnpm`, or `node` commands, use the Node.js version specified in the project's `.nvmrc` file if it exists.
- **Package Manager Detection Policy:** Automatically select the package manager based on lock files in the project root (priority order matters):
    - `pnpm-lock.yaml` → use `pnpm`
    - `yarn.lock` → use `yarn`
    - `package-lock.json` → use `npm`
    - If no lock file is found → default to `npm`
- **Execution:** Wrap all commands in `zsh -cie`.
    - **If `.nvmrc` exists in the current directory:** prefix the command with `nvm use $(cat .nvmrc) &&`
    - **If `.nvmrc` does not exist:** execute the command directly within the `zsh -cie` wrapper.

### Agent Behavior Examples
- **Running tests (`test` script):**
    - With `.nvmrc` and `pnpm-lock.yaml`: `zsh -cie "nvm use $(cat .nvmrc) && pnpm test"`
    - With `.nvmrc` and `yarn.lock`: `zsh -cie "nvm use $(cat .nvmrc) && yarn test"`
    - With `.nvmrc` and `package-lock.json`: `zsh -cie "nvm use $(cat .nvmrc) && npm test"`
    - Without `.nvmrc` and with `yarn.lock`: `zsh -cie "yarn test"`
    - Without any lock file: `zsh -cie "npm test"`

### Notes
- Lock file detection takes precedence over any previously assumed package manager.
- Priority order matters — if multiple lock files exist, the first match in the list is used.
- Always prefer the package manager tied to the lock file to ensure deterministic installs and script execution.
- This logic applies consistently to all commands (`install`, `run`, `exec`, etc.), not just `test`.

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

## Response Formatting & Style
- **Zero Preamble:** Do not use introductory phrases, pleasantries, or acknowledgments (e.g., "Certainly," "I understand," or "Here is...").
- **Brevity:** Deliver the minimum amount of text required for a complete answer. Strictly avoid "fluff" or redundant context.
- **Structural Priority:** Use **Markdown tables** and **bulleted lists** as the default format. Avoid paragraphs longer than two sentences.
- **No Unsolicited Explanations:** Provide results only. Do not explain the logic, background, or reasoning unless explicitly requested with phrases like "Explain" or "Why".
- **Minimalist Code:** Provide only the essential code requested. Use 2-space indentation (except for Go, which uses tabs).
- **No Post-amble:** Do not include summaries, tips, or follow-up suggestions at the end of the response.
