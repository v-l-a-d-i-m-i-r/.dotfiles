---
name: to-tasks
description: Break a plan, spec, or PRD into independently-grabbable tasks using tracer-bullet vertical slices. Use when user wants to convert a plan into task files, create implementation tickets, or break down work into tasks.
---

# To Tasks

Break a plan into independently-grabbable tasks using vertical slices (tracer bullets).

## Process

### 1. Gather context

Work from whatever is already in the conversation context.

### 2. Explore the codebase (optional)

If you have not already explored the codebase, do so to understand the current state of the code.

### 3. Draft vertical slices

Break the plan into **tracer bullet** tasks. Each task is a thin vertical slice that cuts through ALL integration layers end-to-end, NOT a horizontal slice of one layer.

Slices may be 'HITL' or 'AFK'. HITL slices require human interaction, such as an architectural decision or a design review. AFK slices can be implemented and merged without human interaction. Prefer AFK over HITL where possible.

<vertical-slice-rules>
- Each slice delivers a narrow but COMPLETE path through every layer (schema, API, UI, tests)
- A completed slice is demoable or verifiable on its own
- Prefer many thin slices over few thick ones
</vertical-slice-rules>

### 4. Quiz the user

Present the proposed breakdown as a numbered list. For each slice, show:

- **Title**: short descriptive name
- **Type**: HITL / AFK
- **Blocked by**: which other slices (if any) must complete first
- **User stories covered**: which user stories this addresses (if the source material has them)

Ask the user:

- Does the granularity feel right? (too coarse / too fine)
- Are the dependency relationships correct?
- Should any slices be merged or split further?
- Are the correct slices marked as HITL and AFK?

Iterate until the user approves the breakdown.

### 5. Determine where tasks should live

Derive the level from the source PRD's location:

- PRD lives in `./.work-items/prds/` (project level) → tasks go to `./.work-items/tasks/todo/`
- PRD lives in `~/.work-items/prds/` (user level) → tasks go to `~/.work-items/tasks/todo/`

If the source material isn't a PRD file at that path (e.g. it's an ad-hoc plan from conversation), ask the user whether tasks should be stored at the project level or the user level.

### 6. Create the tasks

For each approved slice, create a task file. Use the task body template below.

Generate a work item id for each task by running `~/.bin/work-item-id`. Name each file `task-<work-item-id>-<slug>.md` and write it to the directory chosen in step 5.

Create tasks in dependency order (blockers first) so you can reference real task filenames in the "Blocked by" field.

Write each task assuming the implementer is a low-capability AI model with no access to this conversation and minimal ability to infer intent. Spell out file paths, function/module names, data shapes, and step-by-step behavior rather than summarizing at a high level. Do not assume the implementer will explore the codebase or fill in gaps correctly — resolve ambiguity in the task itself.

<task-template>
## Parent

<path-to-parent-plan-or-prd> (if the source plan or PRD is a file, otherwise omit this section)

## What to build

A detailed, explicit description of this vertical slice, written for a low-capability AI model with no other context. Describe the end-to-end behavior (not layer-by-layer implementation), spelling out relevant file paths, function/module names, inputs/outputs, and edge cases so the task is doable without additional clarification.

## Acceptance criteria

- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3

## Blocked by

- Blocked by <task-file> (if any)

Or "None - can start immediately" if no blockers.

</task-template>
