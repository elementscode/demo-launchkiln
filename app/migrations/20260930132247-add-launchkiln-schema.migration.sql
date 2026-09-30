-- add launchkiln schema

-- Auto-update updatedAt on row changes.
create or replace function touchUpdatedAt()
returns trigger
language plpgsql
as $$
begin
  new.updatedAt = now();
  return new;
end;
$$;

create type userRole as enum ('user', 'admin');

create table users (
  id uuid primary key default uuidGenerateV7(),
  createdAt timestamptz not null default now(),
  updatedAt timestamptz not null default now(),
  email text not null unique,
  passwordHash text not null,
  role userRole not null default 'user'
);

create trigger usersTouchUpdatedAt
  before update on users
  for each row execute function touchUpdatedAt();

create table media (
  id uuid primary key default uuidGenerateV7(),
  createdAt timestamptz not null default now(),
  updatedAt timestamptz not null default now(),
  name text not null,
  contentType text not null,
  data bytea not null,

  -- The cache key. Recomputed with the bytes, so a URL built from it can never
  -- point at stale data.
  hash text generated always as (encode(sha256(data), 'hex')) stored
);

create trigger mediaTouchUpdatedAt
  before update on media
  for each row execute function touchUpdatedAt();

create table posts (
  id uuid primary key default uuidGenerateV7(),
  createdAt timestamptz not null default now(),
  updatedAt timestamptz not null default now(),
  title text not null,
  slug text not null unique,
  excerpt text not null default '',
  body text not null default '',
  coverId uuid references media(id) on delete set null,
  publishedAt timestamptz
);

create index postsPublishedAtIdx on posts (publishedAt desc nulls last);

create trigger postsTouchUpdatedAt
  before update on posts
  for each row execute function touchUpdatedAt();

create table plans (
  id uuid primary key default uuidGenerateV7(),
  createdAt timestamptz not null default now(),
  updatedAt timestamptz not null default now(),
  name text not null,
  priceCents integer not null default 0 check (priceCents >= 0),
  blurb text not null default '',
  features text[] not null default '{}',
  cta text not null default 'Join the waitlist',
  highlighted boolean not null default false,
  sortOrder integer not null default 0
);

create trigger plansTouchUpdatedAt
  before update on plans
  for each row execute function touchUpdatedAt();

create table faqs (
  id uuid primary key default uuidGenerateV7(),
  createdAt timestamptz not null default now(),
  updatedAt timestamptz not null default now(),
  question text not null,
  answer text not null,
  sortOrder integer not null default 0
);

create trigger faqsTouchUpdatedAt
  before update on faqs
  for each row execute function touchUpdatedAt();

create table signups (
  id uuid primary key default uuidGenerateV7(),
  createdAt timestamptz not null default now(),
  updatedAt timestamptz not null default now(),
  email text not null unique,
  code text not null unique default encode(gen_random_bytes(5), 'hex'),
  referredBy uuid references signups(id) on delete set null,
  referrals integer not null default 0,
  position integer
);

create index signupsReferredByIdx on signups (referredBy);
create index signupsRankIdx on signups (referrals desc, createdAt, id);

create trigger signupsTouchUpdatedAt
  before update on signups
  for each row execute function touchUpdatedAt();

-- Every write that can move the line takes this lock first, before it touches
-- a row, so two joins never rerank at once or deadlock on the referrer's row.
create or replace function signupsLock() returns trigger
language plpgsql as $$
begin
  perform pg_advisory_xact_lock(hashtext('signups'));
  return null;
end;
$$;

create trigger signupsLockTrigger
  before insert or delete on signups
  for each statement execute function signupsLock();

create or replace function signupsCountReferral() returns trigger
language plpgsql as $$
begin
  if tg_op = 'INSERT' and new.referredBy is not null then
    update signups set referrals = referrals + 1 where id = new.referredBy;
  elsif tg_op = 'DELETE' and old.referredBy is not null then
    update signups set referrals = greatest(referrals - 1, 0) where id = old.referredBy;
  end if;

  return null;
end;
$$;

create trigger signupsCountReferralTrigger
  after insert or delete on signups
  for each row execute function signupsCountReferral();

-- The line is ordered by referrals, then by who joined first. Only rows whose
-- place actually changed are written, so only their pages hear about it.
create or replace function signupsRerank() returns trigger
language plpgsql as $$
begin
  update signups s
     set position = r.pos
    from (
      select id, (row_number() over (order by referrals desc, createdAt, id))::int as pos
        from signups
    ) r
   where s.id = r.id
     and s.position is distinct from r.pos;

  return null;
end;
$$;

create trigger signupsRerankTrigger
  after insert or delete on signups
  for each statement execute function signupsRerank();

-- Each changed row goes out as its id. The admin's whole-table view reads the
-- row with every column, and the owner's status page reads it through its
-- select, which returns only the public ones.
create or replace function signupsNotify() returns trigger
language plpgsql as $$
declare
  r record;
begin
  r := coalesce(new, old);

  perform pg_notify(channel_name('signups'), json_build_object(
    'op', lower(tg_op),
    'id', r.id
  )::text);

  return null;
end;
$$;

create trigger signupsNotifyTrigger
  after insert or update or delete on signups
  for each row execute function signupsNotify();
