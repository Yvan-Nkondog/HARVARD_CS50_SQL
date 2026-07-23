-- Write a SQL query to find the normal ocean surface 
-- temperature in the Gulf of Maine, off the coast of 
-- Massachusetts. To find this temperature, look at the 
-- data associated with 42.5° of latitude and -69.5° of longitude
-- (https://earth.google.com/web/search/42.5,-69.5/@42.53059612,-70.06085518,-25.91667934a,332193.98637213d,35y,-61.00844387h,46.13637382t,0r/data=Ck4aJBIeGQAAAAAAQEVAIQAAAAAAYFHAKgo0Mi41LC02OS41GAIgASImCiQJ14PWOBzcRUARa3Ou0sBqREAZo3t-queTUMAhTWNBzMAfUsA).
--      Recall that you can find the normal ocean surface temperature 
--      in the 0m column, which stands for 0 meters of depth!

-- Uses normals.db

SELECT "0m"
FROM "normals"
WHERE ("latitude" = 42.5 AND "longitude" = -69.5)
