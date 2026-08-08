-- Supabase schema (starter)
create table public.users (
  id uuid primary key references auth.users(id) on delete cascade,
  student_id varchar(20) unique,
  email varchar(255) unique not null,
  fullname varchar(255) not null,
  phone varchar(20),
  role varchar(30) not null default 'student',
  status boolean default true,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

create table public.buildings(
 id bigserial primary key,
 name varchar(100) not null
);

create table public.floors(
 id bigserial primary key,
 building_id bigint not null references public.buildings(id) on delete cascade,
 floor_number int not null
);

create table public.rooms(
 id bigserial primary key,
 floor_id bigint not null references public.floors(id) on delete cascade,
 room_number varchar(20),
 room_name varchar(100)
);

create table public.departments(
 id bigserial primary key,
 name varchar(100) not null,
 description text
);

create table public.maintenance_reports(
 id bigserial primary key,
 reporter_id uuid references public.users(id),
 department_id bigint references public.departments(id),
 building_id bigint references public.buildings(id),
 floor_id bigint references public.floors(id),
 room_id bigint references public.rooms(id),
 title varchar(255),
 description text,
 priority varchar(20) default 'medium',
 status varchar(30) default 'pending',
 created_at timestamptz default now(),
 updated_at timestamptz default now()
);

create table public.maintenance_history(
 id bigserial primary key,
 report_id bigint references public.maintenance_reports(id) on delete cascade,
 updated_by uuid references public.users(id),
 status varchar(30),
 note text,
 created_at timestamptz default now()
);

create table public.maintenance_images(
 id bigserial primary key,
 report_id bigint references public.maintenance_reports(id) on delete cascade,
 image_url text not null,
 created_at timestamptz default now()
);

create table public.complaints(
 id bigserial primary key,
 reporter_id uuid references public.users(id),
 type varchar(30) not null,
 title varchar(255),
 description text,
 anonymous boolean default false,
 status varchar(30) default 'pending',
 created_at timestamptz default now(),
 updated_at timestamptz default now()
);

create table public.complaint_history(
 id bigserial primary key,
 complaint_id bigint references public.complaints(id) on delete cascade,
 updated_by uuid references public.users(id),
 status varchar(30),
 note text,
 created_at timestamptz default now()
);

create table public.complaint_images(
 id bigserial primary key,
 complaint_id bigint references public.complaints(id) on delete cascade,
 image_url text not null,
 created_at timestamptz default now()
);

create table public.notifications(
 id bigserial primary key,
 user_id uuid references public.users(id),
 title varchar(255),
 message text,
 is_read boolean default false,
 created_at timestamptz default now()
);
