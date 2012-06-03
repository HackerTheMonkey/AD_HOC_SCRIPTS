/*
	This SQL script is used to add a new user to the kickout emails
*/

/*
	Here are the tables to look at
*/
select * from scrules..globaluser;
delete from SCRules..GlobalUser where UserKey='1000000'
select * from scrules..globalusergroup;
select * from scrules..globalusergroupuser;


/*
	Turn on the IDENTITY insert on the GlobalUser table
*/
SET IDENTITY_INSERT SCRULES..GLOBALUSER ON
/*
	Insert a record into the GlobalUser defining the user that
	you are adding as a mail recpient
*/
INSERT INTO scrules..GlobalUser 
	(UserKey, UserId, UserName, OfficeEmailAddress, Password, PowerUser, DisableFlag)
	VALUES 
	('43', 'htopuzov', 'Hristo Topuzov', 'htopuzov@blizoo.bg', ' ', 1, 0);
/*
	Turn off the IDENTITY insert on the GlobalUser table
*/
SET IDENTITY_INSERT SCRULES..GLOBALUSER OFF
/*
	Insert into the GlobalUserGroupUser table
*/
INSERT INTO scrules..GlobalUserGroupUser
            (UserGroupKey, UserKey)
            VALUES
            (1, 43);
