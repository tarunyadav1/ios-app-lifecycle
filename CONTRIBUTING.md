# Contributing

Thanks for helping make AI agents better at iOS development! 🎉

## Ways to help

- **New skills**: e.g. WidgetKit, Live Activities, CloudKit sync, localization, accessibility audits, visionOS, watchOS
- **Better references**: more patterns and examples under `skills/<name>/references/`
- **Bug reports**: a skill triggered at the wrong time, gave outdated API advice, or a command failed
- **Docs**: workflows, translations, screenshots

## Adding or editing a skill

1. Create `skills/<kebab-case-name>/SKILL.md`:
   ```markdown
   ---
   name: <kebab-case-name>
   description: <What it does, in the third person>. Use when the user says "<trigger phrase>", "<another>", ...
   ---

   # Title
   Imperative instructions for the agent...
   ```
2. Keep `SKILL.md` under about 3,000 words. Put long material in `references/` and runnable helpers in `scripts/`.
3. Never put secrets in a skill. Refer to environment variables by name.
4. Irreversible actions (uploads, submissions, purchases, posting) must tell the agent to ask the user first.
5. Run `./scripts/build-plugin.sh` and test it locally:
   ```bash
   /plugin marketplace add ./ios-app-lifecycle
   /plugin install ios-app-lifecycle@ios-app-lifecycle
   ```
6. Add a row to `docs/skills.md` and the table in `README.md`, and a line to `CHANGELOG.md`.

## Pull requests

- One skill or fix per PR
- Describe what triggers the skill and paste an example conversation
- Credit and license any third-party content you adapt (see `THIRD_PARTY_NOTICES.md`)
