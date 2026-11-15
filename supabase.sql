-- O golpe tá aí, cai quem quer! — schema público V3
create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  nickname text not null unique check (char_length(nickname) between 2 and 24),
  xp integer not null default 0 check (xp >= 0),
  unlocked integer not null default 0 check (unlocked between 0 and 3),
  badges text[] not null default '{}',
  best jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.profiles enable row level security;
create policy "public can read leaderboard" on public.profiles for select using (true);
create policy "user inserts own profile" on public.profiles for insert with check (auth.uid() = id);
create policy "user updates own profile" on public.profiles for update using (auth.uid() = id) with check (auth.uid() = id);

create or replace function public.handle_new_user() returns trigger language plpgsql security definer set search_path=public as $$
begin
  insert into public.profiles(id,nickname)
  values(new.id, coalesce(nullif(new.raw_user_meta_data->>'nickname',''), 'jogador-' || substr(new.id::text,1,8)))
  on conflict (id) do nothing;
  return new;
end; $$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created after insert on auth.users for each row execute procedure public.handle_new_user();
