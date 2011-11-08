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
	ADD LastLoginDate datetime NOT NULL DEFAULT(GETDATE())		
	
	SET @version = @version + 1;	
END

--change datatape of user password
IF (@version = 1)
BEGIN
	ALTER TABLE [User]
	ALTER COLUMN [Password] nvarchar(20) NOT NULL
	
	SET @version = @version + 1;	
END

--change string of addresses
IF (@version = 2)
BEGIN
	DROP TABLE AddressCountryCity
	
	ALTER TABLE Address DROP COLUMN [Country]
	ALTER TABLE Address ADD [CountryId] int NOT NULL
	ALTER TABLE Address ADD CONSTRAINT FK_Address_Counry FOREIGN KEY (CountryId) REFERENCES Country(Id)
	ALTER TABLE Address ADD CONSTRAINT FK_Address_City FOREIGN KEY (CityId) REFERENCES City(Id)
	
	SET @version = @version + 1;	
END

--change type of images
IF (@version = 3)
BEGIN
	ALTER TABLE [Photo]
	ALTER COLUMN [Image] image NOT NULL
	
	SET @version = @version + 1;	
END

DECLARE @oldversion int;
SELECT @oldversion = [Version] FROM [System]

--update system table if required
if(@version <> @oldversion)
BEGIN
	UPDATE System
	SET [Version] = @version, Updated = GETDATE()
END