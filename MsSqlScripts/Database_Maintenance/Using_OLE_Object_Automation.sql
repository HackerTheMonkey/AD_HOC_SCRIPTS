use hasdb01;
GO
	-- Declare Variables
	declare @fileSystemHandler int;
	declare @fileHandler int;
	declare @result int;
	-- Create the FileSystemObject
	exec @result = sp_OACreate 'Scripting.FileSystemObject', @fileSystemHandler OUT;
	print 'Creating FileSystemObject, result: ' + ltrim(str(@result));
	-- Open a file for reading/writing
	exec @result = sp_OAMethod @fileSystemHandler, 'OpenTextFile', @fileHandler out, 'C:\testfile01.log', 8, 1;
	print 'Creating a text file, result: ' + ltrim(str(@result));
	-- Check if file exists
	exec @result = sp_OAMethod @fileSystemHandler, 'FileExists', @fileHandler out, 'C:\testfile01.log';
	print 'FileExists, result: ' + ltrim(str(@fileHandler));	
	-- Delete a text file
	exec @result = sp_OAMethod @fileSystemHandler, 'DeleteFile', NULL,  'C:\test.txt';
	print 'Deleting a text file, result: ' + ltrim(str(@result));	
	-- Append data to the recently opened file
	exec @result = sp_OAMethod @fileHandler, 'WriteLine', NULL, 'Somedata to write to the file';
	print 'Writing a text file, result: ' + ltrim(str(@result));
GO