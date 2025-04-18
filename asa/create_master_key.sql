-- Step 1: Create master key
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'is_a_Strong_Password';
GO

SELECT * FROM sys.symmetric_keys;