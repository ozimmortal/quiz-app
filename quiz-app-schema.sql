create database try;
use try;
create table users(
	id int auto_increment primary key,
    name varchar(50),
    email varchar(100) not null,
    password_hash varchar(255) not null,
    created_at timestamp);
    
create table quizzes(
	qid int auto_increment primary key,
    title varchar(120) not null,
   description varchar(255) not null,
   content json,
   userid int,
   foreign key(userid) references users(id) on delete cascade );
   
create table analytics(
	id int auto_increment primary key,
    title varchar(120) not null,
    s_id varchar(20),
    answer json,
    userid int,
    quizid int,
    foreign key(userid) references users(id) on delete cascade,
    foreign key(quizid) references quizzes(qid) on delete cascade);
   
