DO $do$
BEGIN
  IF EXISTS (
    SELECT FROM pg_catalog.pg_roles
    WHERE  rolname = '${group_role}') THEN
    RAISE NOTICE 'Role ${group_role} already exists. Skipping...';
  ELSE
    CREATE ROLE ${group_role} NOLOGIN;
    RAISE NOTICE 'Role ${group_role} is created.';
  END IF;
  
  IF ${make_admin_own} THEN
    GRANT "${db_owner}" TO "${admin_user}";
    RAISE NOTICE 'DB owner role granted to admin user.';
  END IF;
 
  GRANT ${granted_privileges} ON DATABASE "${affected_database}" TO "${group_role}";
  RAISE NOTICE '${granted_privileges} privileges were granted.';

  IF ${make_admin_own} THEN
    REVOKE "${db_owner}" FROM "${admin_user}";
    RAISE NOTICE 'DB owner role revoked from admin user.';
  END IF;
END
$do$;
