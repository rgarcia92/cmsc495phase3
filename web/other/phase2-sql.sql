CREATE TABLE [ROLES](
    [ROLEID] INT PRIMARY KEY NOT NULL UNIQUE, 
    [ROLE] TEXT(50) NOT NULL UNIQUE, 
    [DESCRIPTION] TEXT(255)) WITHOUT ROWID;

INSERT INTO ROLES (ROLEID,ROLE,DESCRIPTION) VALUES (1,'Administrator','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.');
INSERT INTO ROLES (ROLEID,ROLE,DESCRIPTION) VALUES (2,'Editor','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.');
INSERT INTO ROLES (ROLEID,ROLE,DESCRIPTION) VALUES (3,'User','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.');

CREATE TABLE [USERS](
    [USERID] INT PRIMARY KEY NOT NULL UNIQUE, 
    [USERNAME] TEXT(255) NOT NULL UNIQUE, 
    [ROLEID] INT NOT NULL REFERENCES ROLES([ROLEID]), 
    [SALT] TEXT(32) NOT NULL, 
    [PASSWORDHASH] TEXT(255) NOT NULL, 
    [LOCKEDOUT] INT NOT NULL DEFAULT 0, 
    [LASTLOGIN] TEXT(28) NOT NULL) WITHOUT ROWID;

INSERT INTO USERS (USERID,USERNAME,ROLEID,SALT,PASSWORDHASH,LOCKEDOUT,LASTLOGIN) VALUES (1,'rgarcia92@student.umuc.edu',1,
'S8TeYznRvg7ngFwbJziSyWna7qv7p25O','92c2b4de1fbed202974f87c032ae93499266fc2cd4d415d376f335f72f382865',0,'Sun Jan 01 12:01:00 EST 2017');
INSERT INTO USERS (USERID,USERNAME,ROLEID,SALT,PASSWORDHASH,LOCKEDOUT,LASTLOGIN) VALUES (2,'steven.g.burke@gmail.com',2,
'yntK2sKj9mbXcfNxdaxNzrkvEQgeTtw3','a55e91b81cb215502ce53ab018c5d0cd05755fabe2950ebf7449eb371722a2f0',0,'Sun Jan 01 12:01:00 EST 2017');
INSERT INTO USERS (USERID,USERNAME,ROLEID,SALT,PASSWORDHASH,LOCKEDOUT,LASTLOGIN) VALUES (3,'joe.greenm@gmail.com',2,
'BMCZDpxUaqrS4xNv9LnZ6uY6uaZsjzww','d78e7d579ec87ac4e670f261324d9510b49b801416a35641094defc3d070a7e6',0,'Sun Jan 01 12:01:00 EST 2017');
INSERT INTO USERS (USERID,USERNAME,ROLEID,SALT,PASSWORDHASH,LOCKEDOUT,LASTLOGIN) VALUES (4,'denise@peet.io',2,
'nhj4CFgH6ugxrM7BkGz263Dn9XLKtbFs','b317c214c71a3f4e195c2530080e8464cb8086e589722275136a6a81b4e16950',0,'Sun Jan 01 12:01:00 EST 2017');
INSERT INTO USERS (USERID,USERNAME,ROLEID,SALT,PASSWORDHASH,LOCKEDOUT,LASTLOGIN) VALUES (5,'cdbtheone@gmail.com',2,
'd1gOWW61KJLy0gDmHCVOeaCBsgEW86xq','08aa12aa97ee8ce1a368ebeca64b527761a63550672a92cb19e63e09e0bf2877',0,'Sun Jan 01 12:01:00 EST 2017');
INSERT INTO USERS (USERID,USERNAME,ROLEID,SALT,PASSWORDHASH,LOCKEDOUT,LASTLOGIN) VALUES (6,'cmsc495user',3,
'BMCZDpxUaqrS4xNv9LnZ6uY6uaZsjzww','6b80cf9e860ade923fa9d83dc06e563bc0553c27f50ae796e511fb2f533cbb71',0,'Sun Jan 01 12:01:00 EST 2017');
INSERT INTO USERS (USERID,USERNAME,ROLEID,SALT,PASSWORDHASH,LOCKEDOUT,LASTLOGIN) VALUES (6,'cmsc495editor',2,
'NSkmQnjao4nAI6mExMkzh0H0dF2W2Mge','c4f2515606c5fce4065257f252e500ec55c6a31c4397021ccac3620bae6b9b74',0,'Sun Jan 01 12:01:00 EST 2017');
INSERT INTO USERS (USERID,USERNAME,ROLEID,SALT,PASSWORDHASH,LOCKEDOUT,LASTLOGIN) VALUES (6,'cmsc495admin',1,
'DeDtEPLWfZc6YDEkwzUPtytBx55qF7En','a4559af801fb4418199595483d053193ba8670300473bc04e5e87417abff750d',0,'Sun Jan 01 12:01:00 EST 2017');