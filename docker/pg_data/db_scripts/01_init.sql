CREATE TABLE "USER"
(
    id SERIAL PRIMARY KEY,
    org_id INTEGER,
    /* or id INTEGER NOT NULL DEFAULT nextval('user_id_seq'), */
    name VARCHAR(255) NOT NULL,
    email VARCHAR(320) NOT NULL,
    /*
    In addition to restrictions on syntax,
    there is a length limit on email addresses.
    That limit is a maximum of 64 characters (octets)
    in the "local part" (before the "@")
    and a maximum of 255 characters (octets)
    in the domain part (after the "@") for a total length of 320 characters.
    */
    is_valid BOOL DEFAULT 't' NOT NULL,
    created_at TIMESTAMPTZ NOT NULL, /* https://x-team.com/blog/automatic-timestamps-with-postgresql/ */
    updated_at TIMESTAMPTZ NOT NULL
);

/* ALTER SEQUENCE user_id_seq OWNED BY user.id; */

CREATE TABLE "ORGANIZATION"
(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    is_valid BOOL DEFAULT 't' NOT NULL,
    created_at TIMESTAMPTZ NOT NULL,
    updated_at TIMESTAMPTZ NOT NULL
);

INSERT INTO "USER"(id, org_id, name, email, is_valid, created_at, updated_at) VALUES
(DEFAULT, 1, 'John', 'john@local.host', DEFAULT, current_timestamp, current_timestamp),
(DEFAULT, 2, 'Mary', 'mary@super.host', DEFAULT, current_timestamp, current_timestamp),
(DEFAULT, NULL, 'Josh', 'josh@do.main', 'f', current_timestamp, current_timestamp),
(DEFAULT, 2, 'Sara', 'sara@conor.here', DEFAULT, current_timestamp, current_timestamp),
(DEFAULT, 16, 'LastUser', 'last@user.record', DEFAULT, current_timestamp, current_timestamp),
(DEFAULT, 4, 'Dummy2', 'dummy@dummy.record', DEFAULT, current_timestamp, current_timestamp),
(DEFAULT, 4, 'Dummy3', 'dummy@dummy.record', DEFAULT, current_timestamp, current_timestamp),
(DEFAULT, 4, 'Dummy4', 'dummy@dummy.record', DEFAULT, current_timestamp, current_timestamp),
(DEFAULT, 4, 'Dummy5', 'dummy@dummy.record', DEFAULT, current_timestamp, current_timestamp),
(DEFAULT, 4, 'Dummy6', 'dummy@dummy.record', DEFAULT, current_timestamp, current_timestamp),
(DEFAULT, 4, 'Dummy7', 'dummy@dummy.record', DEFAULT, current_timestamp, current_timestamp),
(DEFAULT, 4, 'Dummy8', 'dummy@dummy.record', DEFAULT, current_timestamp, current_timestamp),
(DEFAULT, 4, 'Dummy9', 'dummy@dummy.record', DEFAULT, current_timestamp, current_timestamp),
(DEFAULT, 5, 'Dummy10', 'dummy@dummy.record', DEFAULT, current_timestamp, current_timestamp),
(DEFAULT, 5, 'Dummy11', 'dummy@dummy.record', DEFAULT, current_timestamp, current_timestamp),
(DEFAULT, 6, 'Dummy12', 'dummy@dummy.record', DEFAULT, current_timestamp, current_timestamp),
(DEFAULT, 6, 'Dummy13', 'dummy@dummy.record', DEFAULT, current_timestamp, current_timestamp),
(DEFAULT, 7, 'Dummy14', 'dummy@dummy.record', DEFAULT, current_timestamp, current_timestamp),
(DEFAULT, 8, 'Dummy15', 'dummy@dummy.record', DEFAULT, current_timestamp, current_timestamp),
(DEFAULT, 8, 'Dummy16', 'dummy@dummy.record', DEFAULT, current_timestamp, current_timestamp),
(DEFAULT, 8, 'Dummy17', 'dummy@dummy.record', DEFAULT, current_timestamp, current_timestamp);



INSERT INTO "ORGANIZATION"(id, name, is_valid, created_at, updated_at) VALUES
(1, 'John`s Org.', DEFAULT, current_timestamp, current_timestamp),
(2, 'Mary`s and Sara`s Org.', DEFAULT, current_timestamp, current_timestamp),
(3, 'Nodoby`s Org.', 'f', current_timestamp, current_timestamp),
(4, 'Dummy1 Org.', 't', current_timestamp, current_timestamp),
(5, 'Dummy2 Org.', 't', current_timestamp, current_timestamp),
(6, 'Dummy3 Org.', 't', current_timestamp, current_timestamp),
(7, 'Dummy4 Org.', 't', current_timestamp, current_timestamp),
(8, 'Dummy5 Org.', 't', current_timestamp, current_timestamp),
(9, 'Dummy6 Org.', 't', current_timestamp, current_timestamp),
(10, 'Dummy7 Org.', 't', current_timestamp, current_timestamp),
(11, 'Dummy8 Org.', 't', current_timestamp, current_timestamp),
(12, 'Dummy9 Org.', 't', current_timestamp, current_timestamp),
(13, 'Dummy10 Org.', 't', current_timestamp, current_timestamp),
(14, 'Dummy11 Org.', 't', current_timestamp, current_timestamp),
(15, 'Dummy12 Org.', 't', current_timestamp, current_timestamp),
(16, 'SuperLast Org.', 't', current_timestamp, current_timestamp);
