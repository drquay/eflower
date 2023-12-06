INSERT INTO public.roles (id, active, created_by, created_on, "name", "version") VALUES('2de15f73-7548-4486-b0c8-624bdd6ab835', true, 'SYS', '2022-04-04 20:19:53.232', 'ADMIN', 0);
INSERT INTO public.roles (id, active, created_by, created_on, "name", "version") VALUES('2de15f73-7548-4486-b0c8-624bdd6ab836', true, 'SYS', '2022-04-04 20:19:53.238', 'SALE', 0);
INSERT INTO public.roles (id, active, created_by, created_on, "name", "version") VALUES('2de15f73-7548-4486-b0c8-624bdd6ab838', true, 'SYS', '2022-04-04 20:19:53.242', 'FLORIST', 0);
INSERT INTO public.roles (id, active, created_by, created_on, "name", "version") VALUES('2de15f73-7548-4486-b0c8-624bdd6ab837', true, 'SYS', '2022-04-04 20:19:53.245', 'SHIPPER', 0);
INSERT INTO public.roles (id, active, created_by, created_on, "name", "version") VALUES('2de15f73-7548-4486-b0c8-624bdd6ab834', true, 'SYS', '2022-04-04 20:19:53.245', 'PROVINCIAL_ORDER_MANAGER', 0);
INSERT INTO public.roles (id, active, created_by, created_on, "name", "version") VALUES('2de15f73-7548-4486-b0c8-624bdd6ab833', true, 'SYS', '2022-04-04 20:19:53.245', 'DISPATCHERS', 0);
INSERT INTO public.roles (id, active, created_by, created_on, "name", "version") VALUES('2de15f73-7548-4486-b0c8-624bdd6ab832', true, 'SYS', '2022-04-04 20:19:53.245', 'SALE_ADMIN', 0);

INSERT INTO public."privileges" (id, created_by, created_on, "name", "version") VALUES('2de15f73-7548-4486-b0c8-624bdd6ab831', 'SYS', '2022-04-04 20:25:03.903', 'PRI_ADMIN', 0);
INSERT INTO public."privileges" (id, created_by, created_on, "name", "version") VALUES('2de15f73-7548-4486-b0c8-624bdd6ab830', 'SYS', '2022-04-04 20:25:03.910', 'PRI_SALE', 0);
INSERT INTO public."privileges" (id, created_by, created_on, "name", "version") VALUES('2de15f73-7548-4486-b0c8-624bdd6ab840', 'SYS', '2022-04-04 20:25:03.913', 'PRI_FLORIST', 0);
INSERT INTO public."privileges" (id, created_by, created_on, "name", "version") VALUES('2de15f73-7548-4486-b0c8-624bdd6ab841', 'SYS', '2022-04-04 20:25:03.916', 'PRI_SHIPPER', 0);
INSERT INTO public."privileges" (id, created_by, created_on, "name", "version") VALUES('2de15f73-7548-4486-b0c8-624bdd6ab842', 'SYS', '2022-04-04 20:25:03.916', 'PRI_PROVINCIAL_ORDER_MANAGER', 0);
INSERT INTO public."privileges" (id, created_by, created_on, "name", "version") VALUES('2de15f73-7548-4486-b0c8-624bdd6ab843', 'SYS', '2022-04-04 20:25:03.916', 'PRI_DISPATCHERS', 0);
INSERT INTO public."privileges" (id, created_by, created_on, "name", "version") VALUES('2de15f73-7548-4486-b0c8-624bdd6ab844', 'SYS', '2022-04-04 20:25:03.916', 'PRI_SALE_ADMIN', 0);

INSERT INTO public.role_has_privileges (role_id, privilege_id) VALUES('2de15f73-7548-4486-b0c8-624bdd6ab835', '2de15f73-7548-4486-b0c8-624bdd6ab831');
INSERT INTO public.role_has_privileges (role_id, privilege_id) VALUES('2de15f73-7548-4486-b0c8-624bdd6ab836', '2de15f73-7548-4486-b0c8-624bdd6ab830');
INSERT INTO public.role_has_privileges (role_id, privilege_id) VALUES('2de15f73-7548-4486-b0c8-624bdd6ab838', '2de15f73-7548-4486-b0c8-624bdd6ab840');
INSERT INTO public.role_has_privileges (role_id, privilege_id) VALUES('2de15f73-7548-4486-b0c8-624bdd6ab834', '2de15f73-7548-4486-b0c8-624bdd6ab842');
INSERT INTO public.role_has_privileges (role_id, privilege_id) VALUES('2de15f73-7548-4486-b0c8-624bdd6ab833', '2de15f73-7548-4486-b0c8-624bdd6ab843');
INSERT INTO public.role_has_privileges (role_id, privilege_id) VALUES('2de15f73-7548-4486-b0c8-624bdd6ab832', '2de15f73-7548-4486-b0c8-624bdd6ab844');
INSERT INTO public.role_has_privileges (role_id, privilege_id) VALUES('2de15f73-7548-4486-b0c8-624bdd6ab837', '2de15f73-7548-4486-b0c8-624bdd6ab841');

INSERT INTO public.accounts (id, "blocked", created_by, created_on, "password", username, "version", full_name, phone_number) VALUES('2de15f73-7548-4486-b0c8-624bdd6ab845', false, 'SYS', '2022-04-04 20:30:07.532', '$2a$10$qiSXSUSgiGsRanDY9mJhFO3nuDKgDS9HumdJMIOBfvmzYbgn930BO', 'admin', 0, 'Nguyễn Văn ADMIN', '09xx');
INSERT INTO public.account_has_roles (account_id, role_id) VALUES('2de15f73-7548-4486-b0c8-624bdd6ab845', '2de15f73-7548-4486-b0c8-624bdd6ab835');
