DECLARE @version int;

--insert first record if required
DECLARE @systemRows int;
SELECT @systemRows = COUNT(*) FROM [System]
IF (@systemRows = 0)
BEGIN
	INSERT INTO [System] ([Version],Updated) VALUES (0, GETDATE())
END

SELECT @version = [Version] FROM [System]

--update code should be here
IF(@version = 0)
BEGIN
	ALTER TABLE [User] ADD [Login] nvarchar(20) NOT NULL
	
	SET @version = @version + 1
END

--change phone type to nvarchar
IF(@version = 1)
BEGIN
	ALTER TABLE Photographer ALTER COLUMN Phone nvarchar(12) NOT NULL

	SET @version = @version + 1
END

DECLARE @oldversion int;
SELECT @oldversion = [Version] FROM [System]

--update system table if required
if(@version <> @oldversion)
BEGIN
	UPDATE System
	SET [Version] = @version, Updated = GETDATE()
END