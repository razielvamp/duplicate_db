#!/bin/env python

# https://stackabuse.com/working-with-postgresql-in-python/

import psycopg2
import string
import random
import datetime
import time
import os

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

def mask_string(name):
	if name is None:
		return None
	if len(name) > 2:
		return name[0] + '*'*(len(name)-2) + name[len(name)-1]
	else:
		return '*'*(len(name))

def mask_mail(mail):
	if mail is None:
		return None
	base = mail.split('@')[0]
	domain = mail.split('@')[1].split('.')
	if len(domain) < 2:
		domain[1] = 'none'
	return mask_string(base) + '@' + mask_string(domain[0]) + '.' + '.'.join(domain[1:])

# def random_mail():
# 	base = ''.join([random.choice(string.ascii_letters) for i in range(1,random.randint(6,12))])
# 	domain = ''.join([random.choice(string.ascii_letters) for i in range(1,random.randint(6,24))]) + random.choice(['.com', '.net', '.jp', '.co.jp', '.info'])
# 	return base + '@' + domain

tries = 0
connected = False
exc = None
con = None
while tries < 10 and not connected:
	try:
		con = psycopg2.connect(database=os.environ['POSTGRES_DB'], user=os.environ['POSTGRES_USER'], password=os.environ['POSTGRES_PASSWORD'], host=os.environ['FROM_HOST'], port=os.environ['FROM_PORT'])
		connected = True
	except Exception as e:
		exc = e
		time.sleep(1)
		tries += 1

if not connected:
	if exc is None:
		raise Exception('Unknown Error')
	else:
		raise exc
else:
	print('from connection complete. ' + str(con))

cur = con.cursor()
cur.execute(query)
rows = cur.fetchall()

users = []
orgs = []

time = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")

added_org_ids = []

for row in rows:

	# user_id, org_id, user_name, email, user_is_valid 
	users.append((row[0],row[1],mask_string(row[2]),mask_mail(row[4]),row[5],time,time))
	# org_id, org_name, org_is_valid
	if (not row[1] is None) and (not row[1] in added_org_ids):
		orgs.append((row[1],mask_string(row[3]),row[6],time,time))
		added_org_ids.append(row[1])

cur.close()
con.close()

tries = 0
connected = False
exc = None
con = None
while tries < 10 and not connected:
	try:
		con = psycopg2.connect(database=os.environ['POSTGRES_DB'], user=os.environ['POSTGRES_USER'], password=os.environ['POSTGRES_PASSWORD'], host=os.environ['TO_HOST'], port=os.environ['TO_PORT'])
		connected = True
	except Exception as e:
		time.sleep(1)
		tries += 1

if not connected:
	if exc is None:
		raise Exception('Unknown Error')
	else:
		raise exc
else:
	print('to connection complete. ' + str(con))

cur = con.cursor()

query = '''
DROP TABLE IF EXISTS "USER";
'''

cur.execute(query)

query = '''
DROP TABLE IF EXISTS "ORGANIZATION";
'''

cur.execute(query)

query = '''
CREATE TABLE "USER"
(
    id SERIAL PRIMARY KEY,
    org_id INTEGER,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(320) NOT NULL,
    is_valid BOOL DEFAULT 't' NOT NULL,
    created_at TIMESTAMPTZ NOT NULL,
    updated_at TIMESTAMPTZ NOT NULL
);
'''

cur.execute(query)

query = '''
CREATE TABLE "ORGANIZATION"
(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    is_valid BOOL DEFAULT 't' NOT NULL,
    created_at TIMESTAMPTZ NOT NULL,
    updated_at TIMESTAMPTZ NOT NULL
);
'''

cur.execute(query)

query = '''
INSERT INTO "USER"(id, org_id, name, email, is_valid, created_at, updated_at)
VALUES(%s,%s,%s,%s,%s, TIMESTAMP %s,TIMESTAMP %s) RETURNING id;
'''

for user_data in users:
	cur.execute(query, user_data)

con.commit()

query = '''
INSERT INTO "ORGANIZATION"(id, name, is_valid, created_at, updated_at)
VALUES(%s,%s,%s, TIMESTAMP %s,TIMESTAMP %s) RETURNING id;
'''

for org_data in orgs:
	cur.execute(query, org_data)

con.commit()

cur.close()
con.close()