-- Job Application Assistant — Phase 2 persistence schema
-- Run this in the Supabase SQL editor after creating a project.

create extension if not exists pgcrypto;

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  name text not null default '',
  title text not null default '',
  linkedin_url text not null default '',
  background text not null default '',
  cv_content text not null default '',
  cv_file_name text not null default '',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.role_profiles (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  label text not null default '',
  reference_url text not null default '',
  reference_text text not null default '',
  sort_order integer not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.resume_variants (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  label text not null default '',
  hint text not null default '',
  content text not null default '',
  sort_order integer not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.job_applications (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  company text not null default '',
  role text not null default '',
  stage text not null default 'Wishlist',
  date_applied date,
  notes text not null default '',
  custom_fields jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.profiles enable row level security;
alter table public.role_profiles enable row level security;
alter table public.resume_variants enable row level security;
alter table public.job_applications enable row level security;

drop policy if exists "Users can manage their profile" on public.profiles;
create policy "Users can manage their profile"
  on public.profiles for all
  using (auth.uid() = id)
  with check (auth.uid() = id);

drop policy if exists "Users can manage their role profiles" on public.role_profiles;
create policy "Users can manage their role profiles"
  on public.role_profiles for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

drop policy if exists "Users can manage their resume variants" on public.resume_variants;
create policy "Users can manage their resume variants"
  on public.resume_variants for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

drop policy if exists "Users can manage their job applications" on public.job_applications;
create policy "Users can manage their job applications"
  on public.job_applications for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

create index if not exists role_profiles_user_id_idx on public.role_profiles(user_id, sort_order);
create index if not exists resume_variants_user_id_idx on public.resume_variants(user_id, sort_order);
create index if not exists job_applications_user_id_idx on public.job_applications(user_id, updated_at desc);
