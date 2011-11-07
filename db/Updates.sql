DECLARE @version int;

--insert first record if required
DECLARE @systemRows int;
SELECT @systemRows = COUNT(*) FROM [System]
IF (@systemRows = 0)
BEGIN
	INSERT INTO [System] ([Version],Updated) VALUES (0, GETDATE())
END

SELECT @version = [Version] FROM [System]

--add last login date to users table (sample)
IF (@version = 0)
BEGIN
	ALTER TABLE [User]
	ADD LastLoginDate date NOT NULL DEFAULT(GETDATE())		
	
	SET @version = @version + 1;	
END

UPDATE System
SET [Version] = @version, Updated = GETDATE()