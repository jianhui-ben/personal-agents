# Sample Workflows

Copy and paste these prompts into Claude Code to test the agent system.

## Strategic Planning Workflows

### 1. Product Roadmap
```
have the planner create a 3-month roadmap for building a SaaS product
```

**Expected flow:** Planner → Strategic plan with milestones, deliverables, dependencies

### 2. Feature Implementation Plan
```
plan the development of a dark mode feature for a web application
```

**Expected flow:** Planner → Implementation strategy with approach options and recommendations

### 3. Career Development Plan
```
have the planner create a 6-month learning roadmap for becoming a full-stack developer
```

**Expected flow:** Planner → Learning path with milestones and skill progression

## Research + Content Workflows

### 4. Research + Tutorial
```
research React Server Components and create a beginner tutorial with code examples
```

**Expected flow:** Researcher → Writer → Complete tutorial with explanations and code

### 5. Technology Deep Dive
```
research the latest developments in large language models and create an article explaining it for non-technical readers
```

**Expected flow:** Researcher → Writer → Accessible article with proper explanations

### 6. Industry Analysis
```
research AI agent patterns currently being used in production and summarize the main approaches
```

**Expected flow:** Researcher → Comprehensive analysis with examples and sources

## Implementation Workflows

### 7. Full Stack Development
```
plan the architecture, research FastAPI best practices, implement a REST API with authentication, verify it follows standards, and write comprehensive documentation
```

**Expected flow:** Planner → Researcher → Coder → Fact-Checker → Writer → Complete implementation package

### 8. Code Generation + Documentation
```
have the coder write a Python utility for processing CSV files with error handling, then have the writer create documentation and usage examples
```

**Expected flow:** Coder → Writer → Documented code library

### 9. Code Review + Improvement
```
have the coder review my authentication implementation, identify issues and security concerns, fix them, and document the changes
```

**Expected flow:** Coder (review) → Coder (fix) → Writer (documentation) → Improved code

## Brainstorming Workflows

### 10. Feature Brainstorming
```
brainstorm innovative features for a task management application and evaluate the best ideas
```

**Expected flow:** Planner → Feature list with evaluation and recommendations

### 11. Business Model Innovation
```
have the planner brainstorm alternative business models for a SaaS product and analyze trade-offs
```

**Expected flow:** Planner → Multiple models with pros/cons analysis

## Verification Workflows

### 12. Claim Verification
```
verify these claims: 1) Python is slower than Go for concurrent tasks 2) React is more popular than Vue 3) Machine learning requires large amounts of data
```

**Expected flow:** Fact-Checker → Verification report for each claim with evidence

### 13. Content Verification
```
research AI safety concerns, have the fact-checker verify the claims, and the writer create a balanced article
```

**Expected flow:** Researcher → Fact-Checker → Writer → Verified article

## Complex Multi-Step Workflows

### 14. End-to-End Product Development
```
plan a new feature for a productivity app, research similar features in competitors, implement the feature, verify it meets quality standards, and create user documentation
```

**Expected flow:** Planner → Researcher → Coder → Fact-Checker → Writer → Complete feature package

### 15. Technical Blog Post
```
research a modern web development topic, create a detailed outline, write the article with code examples, verify technical accuracy, and create an introductory summary
```

**Expected flow:** Researcher → Writer → Fact-Checker → Writer (summary) → Complete blog post

### 16. API Design + Implementation
```
plan a REST API design, research best practices and conventions, implement the API with proper documentation, verify it follows standards, and create client usage guides
```

**Expected flow:** Planner → Researcher → Coder → Fact-Checker → Writer → Complete API package

## Quick Single-Agent Tasks

These invoke individual agents directly:

### 17. Just Research
```
have the researcher analyze trends in Python web frameworks
```

### 18. Just Planning
```
have the planner help me decide between microservices and monolithic architecture
```

### 19. Just Code
```
have the coder write a TypeScript React component for a data table
```

### 20. Just Writing
```
have the writer create a technical documentation page for an API
```

## Tips for Success

1. **Be specific**: Include relevant context and requirements
2. **Chain tasks**: Most complex work benefits from multiple agents
3. **Iterate**: Ask agents to refine results (e.g., "expand on the implementation details")
4. **Mix approaches**: Combine planning, research, and implementation
5. **Verify quality**: Use fact-checker for important information

## Customization

Feel free to:
- Modify prompts for your specific needs
- Add domain-specific context
- Request different output formats
- Ask for additional analysis or refinement
- Combine agents in new ways
