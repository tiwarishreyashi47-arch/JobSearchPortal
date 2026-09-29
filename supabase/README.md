# Phase 2 cloud persistence

The Phase 1 app stores profile, resume variants, and tracker data in the browser. This folder defines the Phase 2 Supabase contract for moving that data into authenticated, user-scoped storage.

## Setup

1. Create a Supabase project.
2. Run [`schema.sql`](./schema.sql) in the Supabase SQL Editor.
3. The app will need the project URL and publishable anon key. These are safe for the browser; never add the `service_role` key to the repository or share it in chat.
4. Add the values as Vercel environment variables when the auth integration is wired:
   - `SUPABASE_URL`
   - `SUPABASE_ANON_KEY`

## Data mapping

- `profiles` stores the personal profile and authoritative CV text.
- `role_profiles` stores each target role and its reference URL/text.
- `resume_variants` stores optional role-specific resume variants.
- `job_applications` stores the tracker rows, including custom tracker columns in `custom_fields`.

Every table is protected by Row Level Security and only the signed-in owner can read or change their rows.
