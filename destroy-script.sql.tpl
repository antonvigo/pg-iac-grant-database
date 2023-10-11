DO $do$
BEGIN
  IF ${make_admin_own} THEN
    GRANT "${db_owner}" TO "${admin_user}";
    RAISE NOTICE 'DB owner role granted to admin user.';
  END IF;
 
  REVOKE ${granted_privileges} ON DATABASE "${affected_database}" FROM "${group_role}";
  RAISE NOTICE '${granted_privileges} privileges were revoked.';

  IF ${make_admin_own} THEN
    REVOKE "${db_owner}" FROM "${admin_user}";
    RAISE NOTICE 'DB owner role revoked from admin user.';
  END IF;
END
$do$;
