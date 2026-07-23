## Link to detailed description of the exercise : 

https://cs50.harvard.edu/sql/psets/0/normals/

## Important : 
### In normals.db you’ll find a single table of coordinates, normals. In the normals table, you’ll find the following columns:

1.  id, which uniquely identifies each row (coordinate) in the table
2. latitude, which is the degree of latitude (expressed in decimal format) for the coordinate
3. longitude, which is the degree of longitude (expressed in decimal format) for the coordinate
4. 0m, which is the normal ocean surface temperature (i.e., the normal temperature at 0 meters of depth), in degrees Celsius, at the coordinate
5. 5m, which is the normal ocean temperature at 5 meters of depth, in degrees Celsius, at the coordinate
6. 10m, which is the normal ocean temperature at 10 meters of depth, in degrees Celsius, at the coordinate
7. And observations continue until 5500m, or 5500 meters of depth, for some coordinates!

## Note : 
### Since normals is a wide table, if you want to preview the contents, consider 'selecting' only the latitude, longitude, and a few depth columns. For example :
SELECT "latitude", "longitude", "0m", "5m", "10m", "50m", "500m" FROM "normals" LIMIT 10;
