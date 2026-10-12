# Job Application Assistant

Job Application Assistant is a role-aware job application assistant for candidates who want to tailor an application to a target role without fabricating experience. It is an AI-assisted job-search workflow, not a generic resume generator.

## What it helps with

The prototype helps a candidate:

- create a target-role profile from a representative job description;
- assess role-specific fit against their existing experience;
- tailor resume bullets for a particular role;
- refine generated wording interactively; and
- download generated `.docx` outputs.

The candidate remains in control: suggestions are editable and should be checked against their real background before use.

## Current user flow

1. Add a profile and a target role with its job description or reference text.
2. Provide the role and candidate context to the assistant.
3. Review fit guidance and tailored wording grounded in that context.
4. Refine the result interactively and download an application-ready output.

The current prototype stores profile and application data in the browser. Deployed AI requests go through the existing Vercel serverless endpoint so the provider key is not exposed to the browser.

## Product and technical decisions

- Role context is explicit so recommendations are tied to a target opportunity rather than generic resume advice.
- Browser storage keeps the prototype easy to try without an account or database.
- The server-side generation endpoint keeps the AI provider key out of client-side code when deployed.
- Generated content is editable assistance; the product does not claim to verify employment history or guarantee job outcomes.

## Stack and repository map

- Plain HTML, CSS, and JavaScript in [`index.html`](./index.html)
- Vercel function in [`api/generate.js`](./api/generate.js)
- Static portfolio/demo page in [`portfolio.html`](./portfolio.html)

There is no application build step or package dependency at present. The prototype uses browser APIs and a local static server for development.

## What is implemented and what is not

Implemented:

- role-specific profile and fit workflows;
- interactive resume-bullet tailoring and refinement;
- browser-side application/profile storage;
- downloadable application outputs; and
- server-side AI request handling for a deployed Vercel setup.

Still prototype/deferred:

- job discovery and recommendations are workflow support, not a complete job-board integration;
- browser storage is not cross-device persistence;
- AI output still requires candidate review and can be incomplete or wrong; and
- there is no automated test suite yet.

## Run locally

Serve the repository with any local static server and open the resulting URL. For example:

```bash
npx serve .
```

For local-only use, the interface can accept a Gemini API key in My Profile. For a deployed Vercel project, set `GEMINI_API_KEY` in the project environment and let `/api/generate` handle requests server-side. Do not commit secrets.

Before opening a change, manually exercise profile setup, target-role setup, fit assessment, tailoring, refinement, download, and the configured/unconfigured AI paths.

## Status and limitations

This is a functional portfolio prototype for demonstrating product judgment around role context, AI-assisted writing, privacy boundaries, and a focused browser-first workflow. It should not be treated as a production recruiting system, a factual verifier, or a guarantee of application success.
