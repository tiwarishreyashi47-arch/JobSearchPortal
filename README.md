# Job Application Assistant

A role-aware job application assistant that helps candidates tailor applications to a specific target role without fabricating experience.

## Phase 1 prototype

- Save multiple target role profiles, each anchored by a representative job description.
- Tailor resume bullets and assess fit against a role-specific reference.
- Refine generated outputs interactively.
- Download generated outputs as `.docx` files.
- Keep profile data in the browser and use a secure Vercel endpoint for deployed AI requests.

## Local development

Open `index.html` with a local static server. For local-only use, a Gemini API key can be entered in My Profile. In a deployed Vercel project, set `GEMINI_API_KEY` in the project environment variables; the `/api/generate` function will use it without exposing the key to the browser.

## Deployment

Connect the repository to Vercel, set `GEMINI_API_KEY` for the Preview and Production environments, and deploy. Pull requests should receive preview deployments; production should be updated only after the feature branch is reviewed and merged.
