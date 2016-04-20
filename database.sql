create database traveller;

create table users (
  id serial4 primary key,
  first_name varchar(100),
  last_name varchar(100),
  email_address varchar(300) not null,
  password_digest varchar(400)
);
#done

create table trips (
  id serial4 primary key,
  name varchar(200),
  trip_start timestamp,
  trip_end timestamp,
  budget decimal(8,3),
  user_id integer
);
#done

alter table trips
alter column trip_end
set data type timestamp;

alter table trips
alter column budget
set data type integer;

SELECT EXTRACT(DOY FROM trip_start);
Result: 47
select extract(DOY FROM 'trip_start'());

SELECT EXTRACT(DOY FROM TIMESTAMP 'timestamp here');

create table expenses (
  id serial4 primary key,
  trip_id integer,
  user_id integer,
  amount integer,
  new_budget_amount integer,
  description varchar(100)
);

#  .last to find the most recent record (matching user_id & trip_id)
