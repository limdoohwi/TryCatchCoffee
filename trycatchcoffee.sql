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

CREATE TABLE STORE(
STORE_NO int not null auto_increment,
STORE_NAME varchar(20) not null,
STORE_ADDR varchar(80) not null,
MEMBER_NO int not null,
MEETING_ROOM int not null,
STORE_IP varchar(20),
PRIMARY KEY(STORE_NO),
FOREIGN KEY(MEMBER_NO) REFERENCES MEMBER(MEMBER_NO)
);

CREATE TABLE CART(
CART_NO	int not null auto_increment,
MEMBER_NO	 int not null,
MENU_NUM	 int not null,
MENU_COUNT		 int default 1,
PRIMARY KEY(CART_NO),
FOREIGN KEY(MENU_NUM) REFERENCES MENU(MENU_NUM),
 FOREIGN KEY(MEMBER_NO) REFERENCES MEMBER(MEMBER_NO)
);

CREATE TABLE MEETING_ROOM(
MEETING_NO INT NOT NULL auto_increment,
STORE_NO INT NOT NULL,
PRIMARY KEY(MEETING_NO),
FOREIGN KEY(STORE_NO) REFERENCES STORE(STORE_NO)
);

CREATE TABLE MEETING_RESERVATION(
MEETING_RESERVATION_NO INT NOT NULL auto_increment,
MEETING_NO INT NOT NULL,
MEMBER_NO INT NOT NULL,
STORE_NO INT NOT NULL,
MEETING_RESERVATION_TIME INT NOT NULL,
MEETING_RESERVATION_DATE timestamp default now(),
MEETING_ORDER_DATE timestamp default now(),
PRIMARY KEY(MEETING_RESERVATION_NO),
FOREIGN KEY(MEETING_NO) REFERENCES MEETING_ROOM(MEETING_NO),
FOREIGN KEY(MEMBER_NO) REFERENCES MEMBER(MEMBER_NO),
FOREIGN KEY(STORE_NO) REFERENCES STORE(STORE_NO)

);