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

DECLARE @oldversion int;
SELECT @oldversion = [Version] FROM [System]

--update system table if required
if(@version <> @oldversion)
BEGIN
	UPDATE System
	SET [Version] = @version, Updated = GETDATE()
END