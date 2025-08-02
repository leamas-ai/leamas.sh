# Spec Agent Workflow - Usage Guide and Examples

## Overview

The Spec Agent Workflow System is a comprehensive AI-driven development pipeline that transforms project ideas into production-ready code through specialized agents working in coordinated phases. This guide provides practical examples and usage instructions.

## Quick Start

### Basic Usage

```bash
# Start a complete workflow for a new project
Use the spec-orchestrator agent and say: Create a todo list web application with user authentication

# Start from existing requirements
Use the spec-orchestrator agent with: --from-requirements ./docs/requirements.md

# Execute specific phase only
Use the spec-orchestrator agent: --phase development --from-artifacts ./planning/
```

## Agent Directory Structure

```
.claude/agents/
├── spec-agents/
│   ├── spec-orchestrator.md    # Workflow coordinator
│   ├── spec-analyst.md         # Requirements analysis
│   ├── spec-architect.md       # System design
│   ├── spec-planner.md         # Task planning
│   ├── spec-developer.md       # Code implementation
│   ├── spec-tester.md          # Testing
│   ├── spec-reviewer.md        # Code review
│   └── spec-validator.md       # Final validation
├── ui-ux-master-agent.md       # UI/UX design integration
├── senior-backend-architect.md  # Backend expertise
└── senior-frontend-architect.md # Frontend expertise
```

## Workflow Examples

### Example 1: Simple Web Application

```markdown
**Project**: Personal Blog Platform

**Input to spec-orchestrator**:
Create a personal blog platform with markdown support, user comments, and an admin panel

**Workflow Execution**:

1. **Planning Phase** (45 minutes)
   - spec-analyst creates requirements.md
   - spec-architect designs architecture.md
   - spec-planner generates tasks.md
   - Quality Gate 1: PASS (96/100)

2. **Development Phase** (2 hours)
   - spec-developer implements 15 tasks
   - spec-tester writes comprehensive tests
   - Quality Gate 2: PASS (88/100)

3. **Validation Phase** (30 minutes)
   - spec-reviewer performs code review
   - spec-validator final check
   - Quality Gate 3: PASS (91/100)

**Output**: Complete blog platform with:
- React frontend with markdown editor
- Node.js/Express backend
- PostgreSQL database
- 85% test coverage
- Full documentation
```

### Example 2: Enterprise System

```markdown
**Project**: Multi-tenant SaaS CRM

**Input to spec-orchestrator**:
--quality-threshold 95 --verbose
Build an enterprise CRM system with multi-tenancy, role-based access control, 
API integrations, and real-time analytics dashboard

**Workflow Execution**:

1. **Planning Phase** (2 hours)
   - Detailed requirements with 47 user stories
   - Microservices architecture design
   - 156 implementation tasks
   - Quality Gate 1: PASS (98/100)

2. **Development Phase** (8 hours)
   - 6 microservices implemented
   - GraphQL API gateway
   - React dashboard with D3.js
   - Quality Gate 2: Conditional (84/100)
   - Feedback loop: Performance optimization needed

3. **Revision Cycle** (2 hours)
   - spec-developer optimizes database queries
   - spec-reviewer suggests caching strategy
   - Quality Gate 2: PASS (95/100)

4. **Validation Phase** (1 hour)
   - Comprehensive security audit
   - Performance benchmarks verified
   - Quality Gate 3: PASS (96/100)
```

### Example 3: Mobile-First E-commerce

```markdown
**Project**: E-commerce Mobile App Backend

**Collaboration Example with UI/UX Master**:

spec-orchestrator coordinates with ui-ux-master for design specs

**Phase 1**: UI/UX Design (with ui-ux-master)
- User journey mapping
- Mobile-first component design
- Design system creation

**Phase 2**: Backend Architecture (with senior-backend-architect)
- API design for mobile optimization
- Microservices for scalability
- Redis caching strategy

**Phase 3**: Frontend Integration (with senior-frontend-architect)
- React Native implementation
- Offline-first architecture
- Performance optimization

**Result**: Complete e-commerce platform with:
- Sub-2s page loads on 3G
- 99.9% API uptime
- WCAG AA compliance
- 92% quality score
```

## Command Reference

### Orchestrator Commands

```bash
# Full workflow with options
spec-orchestrator: Create [project description]
  --quality-threshold 90      # Set minimum quality score (default: 85)
  --skip-agents analyst      # Skip specific agents
  --verbose                  # Detailed progress output
  --parallel                 # Enable parallel task execution

# Phase-specific execution
spec-orchestrator: --phase planning "Create a task tracker"
spec-orchestrator: --phase development --from-artifacts ./planning/
spec-orchestrator: --phase validation --project-path ./my-project/

# Workflow control
spec-orchestrator: --status              # Check current workflow status
spec-orchestrator: --pause               # Pause current workflow
spec-orchestrator: --resume              # Resume paused workflow
spec-orchestrator: --abort               # Cancel current workflow
```

### Individual Agent Usage

```bash
# Direct agent invocation (when not using orchestrator)
spec-analyst: Analyze requirements for a social media dashboard
spec-architect: Design architecture from ./requirements.md
spec-planner: Create task breakdown from ./architecture.md
spec-developer: Implement TASK-001 from ./tasks.md
spec-tester: Write tests for ./src/auth/
spec-reviewer: Review code in ./src/
spec-validator: Validate project in ./my-app/
```

## Quality Gates Explained

### Gate 1: Planning Quality (After spec-planner)

```yaml
Criteria:
  - Requirements completeness ≥ 95%
  - Architecture feasibility validated
  - All user stories have acceptance criteria
  - Task breakdown is comprehensive
  
Failure Actions:
  - Return to spec-analyst for clarification
  - Specific feedback on missing elements
```

### Gate 2: Development Quality (After spec-tester)

```yaml
Criteria:
  - All tests passing
  - Code coverage ≥ 80%
  - No critical security vulnerabilities
  - Performance benchmarks met
  
Failure Actions:
  - spec-developer fixes identified issues
  - spec-tester re-runs failed tests
```

### Gate 3: Production Readiness (After spec-validator)

```yaml
Criteria:
  - Overall quality score ≥ 85%
  - All requirements implemented
  - Documentation complete
  - Deployment scripts tested
  
Failure Actions:
  - Route to appropriate agent for fixes
  - May require planning or development revision
```

## Integration with Existing Agents

### UI/UX Collaboration

```markdown
**Scenario**: Building a design-heavy application

1. ui-ux-master creates design specifications
2. spec-orchestrator ingests design specs
3. spec-analyst incorporates UI requirements
4. spec-architect ensures design system integration
5. spec-developer implements with design tokens
6. spec-reviewer validates design compliance
```

### Backend Architecture Integration

```markdown
**Scenario**: Complex distributed system

1. senior-backend-architect provides system design patterns
2. spec-architect incorporates distributed patterns
3. spec-planner creates microservice-specific tasks
4. spec-developer implements with proper patterns
5. spec-tester writes integration tests
6. senior-backend-architect reviews critical components
```

### Frontend Architecture Integration

```markdown
**Scenario**: Modern SPA with SSR

1. senior-frontend-architect defines component architecture
2. spec-architect incorporates frontend patterns
3. spec-planner breaks down by components
4. spec-developer implements with React/Next.js
5. spec-tester writes component tests
6. senior-frontend-architect reviews performance
```

## Common Patterns and Solutions

### Pattern 1: Rapid Prototyping

```bash
# Skip comprehensive planning for MVP
spec-orchestrator: --skip-agents analyst --quality-threshold 75
Create a simple landing page with email capture

# Results in faster but less comprehensive output
```

### Pattern 2: High-Security Application

```bash
# Emphasize security throughout workflow
spec-orchestrator: --quality-threshold 95 --focus security
Create a banking transaction system with fraud detection

# Triggers additional security checks at each phase
```

### Pattern 3: Performance-Critical System

```bash
# Focus on performance optimization
spec-orchestrator: --focus performance --verbose
Create a real-time trading platform with <10ms latency

# Adds performance benchmarks and optimization cycles
```

### Pattern 4: Legacy Modernization

```bash
# Work with existing codebase
spec-orchestrator: --phase analysis --existing-code ./legacy/
Modernize legacy PHP application to microservices

# Analyzes existing code before planning migration
```

## Troubleshooting

### Common Issues

1. **Quality Gate Failures**
   - Check the specific criteria that failed
   - Review feedback provided to agents
   - Allow agents to revise their work
   - Consider adjusting threshold if appropriate

2. **Agent Coordination Issues**
   - Ensure all agents are properly installed
   - Check for file path conflicts
   - Verify artifact naming conventions
   - Review orchestrator logs

3. **Performance Problems**
   - Enable parallel execution
   - Skip non-critical agents
   - Reduce quality thresholds for prototypes
   - Use phase-specific execution

### Debug Mode

```bash
# Enable detailed debugging
spec-orchestrator: --debug --log-level verbose
Create test project

# Outputs detailed logs for troubleshooting
```

## Best Practices

### 1. **Project Preparation**

- Have a clear project description
- Gather any existing documentation
- Define success criteria upfront
- Set appropriate quality thresholds

### 2. **Workflow Optimization**

- Use parallel execution for large projects
- Skip agents when appropriate
- Cache results for iterative development
- Monitor resource usage

### 3. **Quality Management**

- Don't lower thresholds without good reason
- Address quality issues immediately
- Use feedback loops effectively
- Track quality trends over time

### 4. **Collaboration**

- Integrate specialized agents when needed
- Maintain clear communication channels
- Document decisions and changes
- Share artifacts between team members

## Advanced Usage

### Custom Quality Criteria

```typescript
// Add custom quality checks
const customCriteria = {
  name: 'Custom Business Logic',
  evaluate: async (artifacts) => {
    // Custom validation logic
    return score > 90;
  }
};

spec-orchestrator: --custom-criteria ./my-criteria.js
```

### Workflow Templates

```yaml
# Save successful workflow configurations
name: enterprise-web-app
quality_threshold: 95
skip_agents: []
focus_areas: [security, performance]
parallel: true
custom_validators:
  - penetration-test
  - load-test
```

### CI/CD Integration

```yaml
# GitHub Actions example
name: Spec Workflow
on: [push]
jobs:
  agent-workflow:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Run Spec Workflow
        run: |
          claude-code spec-orchestrator \
            --phase validation \
            --project-path . \
            --quality-threshold 90
```

## Conclusion

The Spec Agent Workflow System represents a paradigm shift in AI-assisted development. By leveraging specialized agents working in concert, you can achieve:

- **10x faster development** from concept to code
- **Consistent quality** through automated gates
- **Comprehensive documentation** generated automatically
- **Reduced errors** through systematic validation
- **Better collaboration** through clear workflows

Start with simple projects to understand the flow, then scale up to complex enterprise applications. The system adapts to your needs while maintaining quality standards.

Welcome to the future of AI-driven development!
