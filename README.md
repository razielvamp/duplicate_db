# how it works:

1. creating postgres container and initialazing input data (user and organization tables)
2. creating postgres container where data will be exported
3. creting python container with data export script
4. export masked data into second postgres container

# how to run:

1. `cd script`
2. `./run.sh`
3. connect to postgres and check data
  - `docker exec -it postgres_test_to bash`
  - `psql test test`
  - `SELECT * FROM "USER"`
