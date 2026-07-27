# Interactive Tutorial Architecture

> **Phase**: 7 – Step 5  
> **Version**: 1.0.0  

---

## 1. Step Execution Engine

`TutorialManager` orchestrates step-by-step interactive tutorials:

- **Target UI Keys**: Each `TutorialStep` references a UI key string to highlight relevant toolbar buttons or viewport regions.
- **Floating Banner**: `TutorialOverlayWidget` displays current step instructions and step completion triggers.
