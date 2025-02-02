-- ordered by number of points, descending
with a as (
  SELECT array_agg(the_geom) as points fROM arbrat
SELECT qg.* FROM a, CDB_QuadGrid(a.points, 25)  qg;

with a as (
  SELECT array_agg(the_geom) as points fROM flights where cartodb_id % 3 = 0 limit 100000
  )
SELECT qg.* FROM a, CDB_QuadGrid(a.points, 25, 1000)  qg;

with a as (
  SELECT array_agg(the_geom) as points fROM thrashbins
  )
SELECT qg.* FROM a, CDB_QuadGrid(a.points, 25)  qg;

with a as (
  SELECT array_agg(the_geom) as points fROM benches
  )
SELECT qg.* FROM a, CDB_QuadGrid(a.points, 25)   qg;

with a as (
  SELECT array_agg(the_geom) as points fROM benches where cartodb_id % 3= 0 limit 20000
  )
SELECT qg.* FROM a, CDB_QuadGrid(a.points, 25)  qg;

with a as (
  SELECT array_agg(the_geom) as points fROM streetlamps
  )
SELECT qg.* FROM a, CDB_QuadGrid(a.points, 25)  qg;

-- recursive, for each dataset
SELECT * FROM CDB_QuadGrid_r2('dataset_name', 25);

-- to check the number of resulting cells and coverage
with a as (
  SELECT array_agg(the_geom) as points fROM flights where cartodb_id % 3= 0 limit 100000
  )
SELECT count(1), sum(occurrences), avg(occurrences) FROM a, CDB_QuadGrid(a.points, 25)  qg;
