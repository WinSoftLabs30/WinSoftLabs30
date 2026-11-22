# WinSoftLabs30

Small, tested tools for people who build with AI agents.

Everything here is deterministic and offline wherever it can be: no API keys, no telemetry,
no hidden model calls. If a tool says it runs without keys, it does.

## Free skills

| Skill | What it does | Install |
| --- | --- | --- |
| **[Prompt Doctor](https://github.com/WinSoftLabs30/prompt-doctor-skill)** | Scores a rough prompt, returns one the target model can act on, and decodes jargon-heavy replies in plain words. | `npx skills add WinSoftLabs30/prompt-doctor-skill` |
| **[Test Fix](https://github.com/WinSoftLabs30/test-fix-skill)** | Fixes failing tests without weakening them: flaky vs real failures, minimal diff, approval before anything is touched. | `npx skills add WinSoftLabs30/test-fix-skill` |
| **[Stack Scaffold](https://github.com/WinSoftLabs30/stack-scaffold-skill)** | Next.js 15 + Supabase + Stripe that runs in mock mode before you have any API keys, plus an env check that blocks "done". | `npx skills add WinSoftLabs30/stack-scaffold-skill` |
| **[Screenshot to Code](https://github.com/WinSoftLabs30/screenshot-to-code-skill)** | One screenshot to one React + Tailwind component in your design tokens, with a demo and honest notes. | `npx skills add WinSoftLabs30/screenshot-to-code-skill` |

Also on ClawHub: [Prompt Doctor](https://clawhub.ai/winsoftlabs30/skills/prompt-doctor),
[Test Fix](https://clawhub.ai/winsoftlabs30/skills/test-fix),
[Stack Scaffold](https://clawhub.ai/winsoftlabs30/skills/stack-scaffold-skill),
[Screenshot to Code](https://clawhub.ai/winsoftlabs30/skills/screenshot-to-code).

## How these are built

- Node 22.6+. TypeScript runs directly: no build step, no runtime dependencies.
- Tests cover the behaviour, not the demo. The numbers are in each README.
- Honest limits: what a tool does *not* do is written down, not discovered later.
- The free edition is the workflow. The paid edition is the tested scripts around the
  same workflow; links appear here when they go live.

Free editions are MIT-0: use them, change them, ship them.
