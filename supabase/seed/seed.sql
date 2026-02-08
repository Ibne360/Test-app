insert into locations_districts (name_bn)
values ('ঢাকা');

insert into locations_thanas (district_id, name_bn)
select id, 'ধানমন্ডি' from locations_districts limit 1;

insert into locations_unions (thana_id, name_bn)
select id, 'ইউনিয়ন-১' from locations_thanas limit 1;

insert into products (name_bn, description_bn, price, weight_kg, stock_mode)
values
  ('চাল', 'উচ্চ মানের চাল', 60, 1, 'On-demand'),
  ('আটা', 'ফ্রেশ আটা', 50, 1, 'On-demand');
