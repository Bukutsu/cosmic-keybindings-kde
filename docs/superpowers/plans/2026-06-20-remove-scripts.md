# Remove Scripts Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Remove scripts from the repository and update the README to rely solely on KDE scheme importing.

**Architecture:** Use git command to delete tracked script files, and edit README.md to remove all references to installer/uninstaller scripts.

**Tech Stack:** Git, Bash, Markdown

## Global Constraints

- No references to scripts or headless script installation in documentation.
- The installation section in README.md should only explain how to import the scheme via the KDE System Settings GUI.

---

### Task 1: Clean up Repository and Documentation

**Files:**
- Delete: `scripts/remove.sh`
- Modify: `README.md:5-34`

**Interfaces:**
- Consumes: None
- Produces: None

- [ ] **Step 1: Delete scripts directory content via Git**

Run: `git rm scripts/remove.sh`
Expected: File staged for deletion.

- [ ] **Step 2: Update README.md to remove all references to script execution**

Modify `/home/bukutsu/Projects/cosmic-keybindings-kde/README.md` to remove script installation instructions, script uninstallation instructions, and notes/warnings referencing scripts.

- [ ] **Step 3: Verify there are no remaining scripts or references**

Run: `git status`
Expected: `scripts/remove.sh` is deleted and `README.md` is modified.

Run: `grep -rn "scripts/" /home/bukutsu/Projects/cosmic-keybindings-kde/` (excluding `.git` and `docs/`)
Expected: No matches returned.

- [ ] **Step 4: Commit changes**

Run:
```bash
git commit -am "chore: remove installation and removal scripts, update README.md"
```
