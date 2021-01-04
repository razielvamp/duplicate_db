#!/bin/env python

# https://stackabuse.com/working-with-postgresql-in-python/

import psycopg2

query = '''
SELECT
	"USER".id,
	org_id,
	"USER".name as user_name,
	"ORGANIZATION".name as org_name,
    email,
    "USER".is_valid as user_is_valid,
    "ORGANIZATION".is_valid as org_is_valid
FROM
	"USER"
LEFT JOIN "ORGANIZATION" ON "USER".org_id = "ORGANIZATION".id
ORDER BY id
LIMIT 10;
'''

con = psycopg2.connect(database="test", user="test", password="test", host="127.0.0.1", port="54321")

cur = con.cursor()
cur.execute(query)
rows = cur.fetchall()

print(rows)