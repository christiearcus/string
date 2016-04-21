-- create database traveller;

create table users (
  id serial4 primary key,
  first_name varchar(100),
  last_name varchar(100),
  email_address varchar(300) not null,
  password_digest varchar(400)
);

create table trips (
  id serial4 primary key,
  name varchar(200),
  trip_start timestamp,
  trip_end timestamp,
  og_budget integer,
  budget integer,
  user_id integer
);

create table expenses (
  id serial4 primary key,
  trip_id integer,
  user_id integer,
  amount integer,
  new_budget_amount integer,
  description varchar(100)
);
