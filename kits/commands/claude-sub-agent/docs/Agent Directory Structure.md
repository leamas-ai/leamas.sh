# Agent Directory Structure

This directory contains specialized AI agents for the Claude Sub-Agent system. The agents are organized by their domain expertise and workflow roles.

## Directory Organization

```
agent/
├── documentation/               # System documentation and guides
│   ├── agent-workflow-system.md     # Complete workflow system documentation
│   ├── agent-workflow-usage-guide.md # Usage examples and best practices
|   ├── agent-workflow-system.md # 
├── spec-agents/                 # Spec workflow agents
│   ├── spec-orchestrator.md    # Master workflow coordinator
│   ├── spec-analyst.md         # Requirements analysis specialist
│   ├── spec-architect.md       # System architecture designer
│   ├── spec-planner.md         # Task breakdown and planning
│   ├── spec-developer.md       # Implementation specialist
│   ├── spec-tester.md          # Comprehensive testing expert
│   ├── spec-reviewer.md        # Code review specialist
│   └── spec-validator.md       # Final validation expert
│
├── frontend/                    # Frontend specialized agents
│   └── senior-frontend-architect.md # React/Vue/Next.js expert
│
├── backend/                     # Backend specialized agents
│   └── senior-backend-architect.md  # Go/TypeScript backend expert
│
├── ui-ux/                       # UI/UX design agents
│   └── ui-ux-master.md         # UI/UX design and implementation expert
│
└── refactor-agent.md           # Code refactoring specialist

```

## Agent Categories

### 1. Spec Workflow Agents

The core workflow system that automates the entire development lifecycle:

- **Planning Phase**: spec-analyst → spec-architect → spec-planner
- **Development Phase**: spec-developer → spec-tester
- **Validation Phase**: spec-reviewer → spec-validator
- **Coordination**: spec-orchestrator manages the entire workflow

### 2. Domain Specialists

Expert agents for specific technical domains:

- **Frontend**: Modern JavaScript frameworks, performance, accessibility
- **Backend**: Distributed systems, APIs, databases, security
- **UI/UX**: Design systems, user experience, accessibility

### 3. Utility Agents

- **refactor-agent**: Code quality and refactoring specialist

## Usage

### Basic Workflow

```bash
# Start a complete project workflow
Use spec-orchestrator: Create a task management web application

# Use a specific specialist
Use senior-frontend-architect: Review my React component architecture
```

### Direct Agent Usage

```bash
# Planning phase
Use spec-analyst: Analyze requirements for an e-commerce platform

# Development phase  
Use spec-developer: Implement user authentication system

# Review phase
Use spec-reviewer: Review the authentication implementation
```

## Quality Gates

The workflow includes three quality gates:

1. **Planning Gate** (95% threshold) - After spec-planner
2. **Development Gate** (80% threshold) - After spec-tester  
3. **Production Gate** (85% threshold) - After spec-validator

## Integration

Agents can work together:

- UI/UX Master → provides design specs → Spec Workflow
- Senior Backend Architect → enhances → Spec Architect designs
- Senior Frontend Architect → guides → Spec Developer implementation

## Best Practices

1. **Start with spec-orchestrator** for complete projects
2. **Use domain specialists** for specific expertise
3. **Follow the workflow** for consistent quality
4. **Leverage quality gates** to ensure standards
5. **Enable parallel execution** for large projects

## Contributing

When adding new agents:

1. Place in appropriate category directory
2. Follow the YAML frontmatter format
3. Include clear description and tool requirements
4. Update this README with the new agent
5. Test integration with existing workflow

## Version History

- v1.0: Initial spec workflow system
- v1.1: Added domain specialist agents
- v1.2: Enhanced orchestration and quality gates
