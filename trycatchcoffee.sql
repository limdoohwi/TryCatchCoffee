use trycoffee;

create table member(
	member_no	int not null auto_increment,
    member_email varchar(20) not null unique,
    member_pw	 varchar(20) not null,
    member_name  varchar(15) not null,
    member_tel   varchar(11) not null,
    member_birth date,
    member_mileage int default 0,
    member_regdate timestamp default now(),
    member_code  int default 1,
    primary key(member_no)
);
CREATE TABLE MENU_CATEGORY(
MENU_CATEGORY_NUM	 int not null auto_increment,
MENU_CATEGORY_NAME	 VARCHAR(30) not null unique,
PRIMARY KEY(MENU_CATEGORY_NUM)
);
CREATE TABLE MENU(
MENU_NUM	  int not null auto_increment,
MENU_NAME	  varchar(30) not null unique,
MENU_PRICE	  int not null,
MENU_CATEGORY_NUM	 int not null,
MENU_IMAGE  	  varchar(30),
PRIMARY KEY(MENU_NUM),
FOREIGN KEY(MENU_CATEGORY_NUM) REFERENCES MENU_CATEGORY(MENU_CATEGORY_NUM)
);

select * from member;

delete from member where member_no=6;

select * from menu_category;

select * from menu;