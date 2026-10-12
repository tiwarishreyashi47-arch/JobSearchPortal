# Job Application Assistant

Job Application Assistant is a role-aware job application assistant for candidates who want to tailor an application to a target role without fabricating experience. It is an AI-assisted job-search workflow, not a generic resume generator.

## What it helps with

The prototype helps a candidate:

- create multiple target-role profiles from representative job descriptions;
- assess role-specific fit against their existing experience;
- tailor resume bullets for a particular role;
- refine generated wording interactively;
- track applications and download generated `.docx` outputs.

The product keeps the candidate in the loop: AI suggestions are editable and should be checked against the candidate’s real background before use.

## How it works

1. The candidate saves a profile and a target role with its job description or reference text.
2. The browser sends the relevant context to the server-side generation endpoint.
3. The assistant returns fit guidance and tailored wording grounded in the supplied profile and role.
4. The candidate refines the result, saves a role-specific variant, and downloads an output when ready.

Phase 1 keeps profile, role, resume-variant, and tracker data in browser storage. The first Phase 2 slice adds an optional Supabase contract for authenticated, user-scoped persistence; it is additive and does not replace the browser-only path when Supabase is not configured.

## Product and technical decisions

- Role context is explicit so recommendations are tied to a target opportunity rather than generic resume advice.
- The deployed app uses a Vercel serverless endpoint for AI requests, keeping the provider key out of the browser.
- Local browser storage makes the prototype easy to try without an account or database.
- Supabase tables and Row Level Security are defined in [`supabase/`](./supabase/) for the next persistence step.
- Generated content is presented as editable assistance; the product does not claim to verify employment history or guarantee job outcomes.

## Stack and repository map

- Plain HTML, CSS, and JavaScript in [`index.html`](./index.html)
- Vercel function in [`api/generate.js`](./api/generate.js)
- Provider/configuration helpers in [`api/config.js`](./api/config.js)
- Optional Supabase schema and data contract in [`supabase/`](./supabase/)
- Static portfolio/demo page in [`portfolio.html`](./portfolio.html)

There is no application build step or package dependency at present. The prototype uses the browser Web APIs and a local static server for development.

## Real, optional, and simulated

Implemented in the current prototype:

- role-specific profile and fit workflows;
- interactive tailoring and browser-side tracking;
- downloadable application outputs;
- server-side AI request handling for a deployed Vercel setup;
- an additive Supabase schema for future authenticated persistence.

Still prototype/deferred:

- job discovery and recommendations are workflow support, not a complete job-board integration;
- browser storage is not cross-device persistence;
- the Supabase contract is not a substitute for a fully enabled production account/auth flow;
- AI output still requires candidate review and can be incomplete or wrong.

## Run locally

Serve the repository with any local static server and open the resulting URL. For example:

```bash
npx serve .
```

For local-only use, the interface can accept a Gemini API key in the profile flow. For a deployed Vercel project, set `GEMINI_API_KEY` in the project environment and let `/api/generate` handle requests server-side. Do not commit secrets.

The repository has no automated test suite yet. Before opening a change, manually exercise profile creation, target-role setup, tailoring, refinement, download, and the configured/unconfigured AI paths.

## Status and limitations

This is a functional portfolio prototype moving from a browser-first Phase 1 toward optional cloud persistence. It is useful for demonstrating product judgment around role context, AI-assisted writing, privacy boundaries, and incremental architecture. It should not be treated as a production recruiting system, a factual verifier, or a guarantee of application success.
