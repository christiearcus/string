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
  trip_start date,
  trip_end date,
  budget decimal,
  user_id integer
);

#see gist for unanswered questions.

create table expenses (
  id serial4 primary key,
  amount decimal,
  trip_id integer
);

create table notes (
  id serial4 primary key,
  body varchar(1000),
  trip_id integer
);
# not sure if i'll use this
