-- Step 1: (In create_master_key.sql file)
-- Step 2: Define a database scoped credential
CREATE DATABASE SCOPED CREDENTIAL ADLS_DE
	WITH IDENTITY = 'dtcdezcasa', -- Find it in storage account
		 SECRET = 'XXXX'; -- primaryMasterKey
GO

-- Step 3: Create an external data source
CREATE EXTERNAL DATA SOURCE adls_review
WITH (
	TYPE = HADOOP,
	LOCATION = 'wasbs://dtcdezca-adls@dtcdezcasa.blob.core.windows.net/',
	CREDENTIAL = ADLS_DE
);
GO

-- Step 4: Create an external file format
CREATE EXTERNAL FILE FORMAT ParquetFileFormat
WITH (
    FORMAT_TYPE = PARQUET,
	DATA_COMPRESSION = 'org.apache.hadoop.io.compress.SnappyCodec'
);
GO

-- Step 5: Create the external table
CREATE EXTERNAL TABLE [dbo].[ExternalReviewTable]
(
    [review_id] VARCHAR(50),
    [user_id] VARCHAR(50),
    [business_id] VARCHAR(50),
    [stars] INT,
    [useful] INT,
    [funny] INT,
    [cool] INT,
    [text] NVARCHAR(MAX),
    [date] DATETIME2,
    [id] VARCHAR(50)
)
WITH
(
    LOCATION = '/review/',
    DATA_SOURCE = adls_review,
    FILE_FORMAT = ParquetFileFormat
);
GO

-- Select data to check
SELECT TOP 20 * FROM ExternalReviewTable;
