# Historical Figures Debate Agents for Claude Code

This repository contains custom Claude Code sub-agents that allow historical figures to debate contemporary topics while Claude acts as a neutral moderator.

## Quick Installation with leamas

The easiest way to install these agents is using [leamas](https://github.com/leamas-ai/leamas.sh). After leamas has been installed you can run:

```bash
# Install historical figures debate agents for Claude Code
leamas agent@agents-historical-figures
```
From your project directory to install all of the agents and then begin you discussion. Once installed, the agents will be available in your Claude Code environment and can be invoked using the Task tool with their agent names.


## Installation via GitHub

To install from GitHub to your global Claude Code instance:

```bash
cd ~/.claude/agents
git clone https://github.com/leamas-ai/agents-historical-figures.git
```

Or to install only to your project, change into your project directory and run:

```bash
cd .claude/agents
git clone https://github.com/leamas-ai/agents-historical-figures.git
```

If you do not have a `.claude/agents` directory, then create it before running the `git` commands.

## Available Agents

### Debate Moderator
- **File**: `agents/debate-moderator.md`
- **Role**: Neutral facilitator of intellectual discourse
- **Features**: Structured debate format, balanced moderation, synthesis of arguments

### Historical Figures

1. **Socrates** (`agents/socrates-agent.md`)
   - Classical Greek philosopher (470-399 BCE)
   - Uses Socratic method of questioning
   - Focuses on ethical and definitional inquiries

2. **Aristotle** (`agents/aristotle-agent.md`)
   - Greek philosopher and polymath (384-322 BCE)
   - Systematic, empirical approach
   - Expertise in logic, ethics, politics, and natural science

3. **Marcus Aurelius** (`agents/marcus-aurelius-agent.md`)
   - Roman Emperor and Stoic philosopher (121-180 CE)
   - Practical wisdom from leadership experience
   - Focus on what's within our control

4. **Leonardo da Vinci** (`agents/leonardo-da-vinci-agent.md`)
   - Renaissance polymath (1452-1519)
   - Integrates art and science
   - Visual thinking and innovation

5. **Marie Curie** (`agents/marie-curie-agent.md`)
   - Pioneering physicist and chemist (1867-1934)
   - First woman Nobel laureate
   - Advocate for women in science

6. **Albert Einstein** (`agents/albert-einstein-agent.md`)
   - Theoretical physicist (1879-1955)
   - Revolutionary thinker on space, time, and reality
   - Humanitarian and philosopher-scientist

## How to Use

### Basic Historical Debate Setup

1. **Start a debate on any contemporary topic**:
   ```
   I want to organize a debate on [topic] between historical figures. 
   Please use:
   - The debate-moderator agent to facilitate
   - [Choose 2-4 historical figure agents] as participants
   ```

2. **Example debate prompt**:
   ```
   Please organize a debate on "The role of artificial intelligence in society" with:
   - debate-moderator as the facilitator
   - socrates-agent, aristotle-agent, and marie-curie-agent as participants
   
   Have them discuss AI ethics, benefits, and risks from their unique perspectives.
   ```

### Advanced Usage

#### 1. **One-on-One Philosophical Dialogue**
   ```
   Have Socrates and Aristotle discuss the nature of knowledge, 
   with the moderator guiding their conversation.
   ```

#### 2. **Historical Advisory Panel**
   ```
   I need advice on [modern issue]. Please convene a panel with 
   Einstein, da Vinci, and Marcus Aurelius to provide their perspectives.
   ```

#### 3. **Cross-Era Scientific Discussion**
   ```
   Have Marie Curie and Albert Einstein debate with Leonardo da Vinci 
   about the relationship between art and science.
   ```

#### 4. **Ethical Dilemma Analysis**
   ```
   Present this ethical dilemma to Socrates, Marcus Aurelius, and Aristotle:
   [describe dilemma]
   Have them explore it from their philosophical frameworks.
   ```

#### 5. **Innovation Workshop**
   ```
   Use Leonardo da Vinci and Einstein agents to brainstorm solutions 
   for [contemporary problem], with the moderator synthesizing ideas.
   ```

## Features and Capabilities

### Debate Structure
The moderator agent follows this format:
1. **Opening** - Topic introduction and participant introductions
2. **Initial Positions** - Each figure states their stance
3. **Rebuttals** - Responses to initial positions
4. **Open Discussion** - Guided free-form debate
5. **Closing Statements** - Final thoughts from each participant
6. **Synthesis** - Moderator's balanced summary

### Agent Characteristics

- **Authentic Voice**: Each agent maintains their historical personality and speaking style
- **Philosophical Consistency**: Arguments align with their known beliefs and methods
- **Modern Adaptation**: Can engage with contemporary concepts while maintaining historical perspective
- **Interactive Depth**: Agents respond to each other's arguments dynamically

### Special Capabilities

1. **Cross-Temporal Understanding**: Historical figures can grasp modern concepts when explained
2. **Philosophical Integration**: Different schools of thought interact meaningfully
3. **Practical Application**: Historical wisdom applied to contemporary challenges
4. **Educational Value**: Learn philosophy and history through engaging dialogue

## Example Commands

### Quick Start
```
"Moderate a debate between Socrates and Einstein on whether truth is absolute or relative"
```

### Complex Scenario
```
"I want to explore the ethics of genetic engineering. Please organize a panel with:
- Aristotle for virtue ethics perspective
- Marcus Aurelius for Stoic view on nature
- Marie Curie for scientific progress angle
- Leonardo da Vinci for innovation and human enhancement
Let them discuss for 5 rounds with the moderator guiding."
```

### Educational Use
```
"Help me understand different philosophical approaches to happiness by having 
Aristotle (eudaimonia), Marcus Aurelius (Stoic contentment), and Socrates 
(examined life) explain their views in a moderated discussion"
```

## Tips for Best Results

1. **Be Specific**: Clearly state the topic and which agents you want to use
2. **Set Context**: Provide background on contemporary issues for historical figures
3. **Guide Direction**: Tell the moderator to focus on specific aspects if needed
4. **Multiple Rounds**: Request multiple rounds of debate for deeper exploration
5. **Ask for Summaries**: Request the moderator to synthesize key insights

## Extending the System

To add new historical figures:
1. Create a new `.md` file in the `agents/` directory
2. Include sections for: Core Identity, Speaking Style, Key Beliefs, Debate Approach
3. Ensure the agent can engage with modern topics while maintaining historical authenticity
4. Test the agent in debates with existing figures

## Notes

- Agents work best when given clear topics and debate structures
- The moderator ensures balanced participation and civil discourse
- Historical figures maintain their authentic worldviews while engaging modern topics
- Debates can be educational, entertaining, and provide unique insights