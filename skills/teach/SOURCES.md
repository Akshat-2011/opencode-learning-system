# Sources and adaptations

This teaching system is a merge of two upstream projects, vendored (not symlinked) into `~/.config/opencode/` and adapted to opencode primitives.

| Upstream | Commit | Used for |
| --- | --- | --- |
| [mattpocock/skills](https://github.com/mattpocock/skills) — `skills/productivity/teach/` | `c55ee46073ed923f86ce59a5eb3b6d895095d1b7` | Workspace/lesson workflow in `skills/teach/SKILL.md`; `MISSION-FORMAT.md`, `LEARNING-RECORD-FORMAT.md`, `GLOSSARY-FORMAT.md`, `RESOURCES-FORMAT.md` copied verbatim |
| [amosblomqvist/learn](https://github.com/amosblomqvist/learn) — `skills/teach/`, `skills/visualize/`, `agents/` | `7cfd8942f82ab9476e63572387e1fe9bcea5082c` | Pedagogy in `skills/teach/PEDAGOGY.md`; `skills/visualize/`; `researcher`, `mermaid-maker`, `svg-maker` prompts |

Vendored on 2026-09-27.

## What was adapted

- **pi → opencode**: `ask_user_question` extension → native `question` tool; `quiz` TUI extension → graded `question` tool MCQs with post-answer grading; `subagent` tool → `task` tool; `web_search`/`web_fetch`/`safe_bash` → `websearch`/`webfetch`; pi `visual-tools` (`write_mermaid`/`render_mermaid`/`svg_tools`) → `write`/`edit`/`bash` + render scripts + `read` on the PNG for visual verification.
- **Obsidian/pi-log framing** → self-contained HTML lessons in `./lessons/`, shared components in `./assets/`, visuals in `./viz/`, per Matt's workspace scheme.
- **Frontmatter**: Claude Code / pi fields (`disable-model-invocation`, `argument-hint`, `tools`, `thinking`) removed; opencode fields used. Agents are `mode: subagent` with `permission` blocks. No `model` is pinned, so agents inherit the user's default model.
- **`md-log` and `visual-tools` packages intentionally dropped** — the agent writes lesson/state files directly, and the render scripts replace the pi tooling.

## Updating from upstream

```bash
git clone --depth 1 https://github.com/mattpocock/skills.git /tmp/opencode/mattpocock-skills
git clone --depth 1 https://github.com/amosblomqvist/learn.git /tmp/opencode/amosblomqvist-learn
diff /tmp/opencode/mattpocock-skills/skills/productivity/teach/SKILL.md \
     ~/.config/opencode/skills/teach/SKILL.md
```

Re-apply adaptations by hand (they are deliberate, not mechanical), then update the commit hashes above. The four `*-FORMAT.md` files are copied verbatim and can be re-copied directly.
