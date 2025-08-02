# Claude Code Custom Agents

This repository contains custom agents for Claude Code.

## Installation

### For Project-Specific Use
Copy the agents to your project's `.claude/agents/` directory:
```bash
mkdir -p .claude/agents
cp agents/*.md .claude/agents/
```

### For Global Use (All Projects)
Copy the agents to your user's Claude directory:
```bash
mkdir -p ~/.claude/agents
cp agents/*.md ~/.claude/agents/
```

## Available Agents

- **code-refactorer**: Code refactoring assistance
- **content-writer**: Content writing assistance
- **frontend-designer**: Frontend design assistance
- **prd-writer**: Product requirement document writing
- **project-task-planner**: Project planning and task breakdown
- **security-auditor**: Security audit assistance
- **vibe-coding-coach**: Coding guidance and coaching

## Usage

Once installed, Claude Code will automatically detect and use these agents when appropriate for your tasks.