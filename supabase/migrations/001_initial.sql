create table if not exists locations_districts (
  id uuid primary key default gen_random_uuid(),
  name_bn text not null
);

create table if not exists locations_thanas (
  id uuid primary key default gen_random_uuid(),
  district_id uuid references locations_districts(id),
  name_bn text not null
);

create table if not exists locations_unions (
  id uuid primary key default gen_random_uuid(),
  thana_id uuid references locations_thanas(id),
  name_bn text not null
);

create table if not exists profiles (
  id uuid primary key,
  role text not null default 'CUSTOMER',
  phone text,
  email text,
  district_id uuid references locations_districts(id),
  thana_id uuid references locations_thanas(id),
  union_id uuid references locations_unions(id),
  created_at timestamptz default now()
);

create table if not exists products (
  id uuid primary key default gen_random_uuid(),
  name_bn text not null,
  description_bn text,
  price int not null,
  wholesale_price int,
  weight_kg numeric not null default 0,
  image_url text,
  is_active boolean default true,
  stock_mode text default 'On-demand',
  max_per_batch int
);

create table if not exists batches (
  id uuid primary key default gen_random_uuid(),
  thana_id uuid references locations_thanas(id),
  status text not null default 'OPEN',
  start_at timestamptz not null,
  end_at timestamptz not null,
  min_orders int not null default 10,
  extend_once_used boolean default false
);

create table if not exists orders (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references profiles(id),
  batch_id uuid references batches(id),
  status text not null default 'PLACED',
  delivery_charge int not null default 50,
  service_charge int not null default 0,
  total_amount int not null,
  total_weight_kg numeric not null default 0,
  created_at timestamptz default now()
);

create table if not exists order_items (
  id uuid primary key default gen_random_uuid(),
  order_id uuid references orders(id),
  product_id uuid references products(id),
  qty int not null,
  unit_price int not null,
  unit_weight_kg numeric not null
);

create table if not exists wallet_transactions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references profiles(id),
  type text not null,
  amount int not null,
  ref_order_id uuid references orders(id),
  created_at timestamptz default now()
);

create table if not exists manager_thana_map (
  manager_user_id uuid references profiles(id),
  thana_id uuid references locations_thanas(id),
  primary key (manager_user_id, thana_id)
);

alter table products enable row level security;
alter table orders enable row level security;
alter table batches enable row level security;

create policy "public read active products" on products
  for select using (is_active = true);
