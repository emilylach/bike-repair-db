-- Creates (or recreates) the BikeShop database.
USE master;

IF DB_ID(N'BikeShop') IS NOT NULL
BEGIN
    RAISERROR(N'BikeShop exists: disconnecting users and dropping it', 0, 1) WITH NOWAIT;
    -- Prepare database for modification and force users out
    ALTER DATABASE BikeShop SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    -- Delete old copy 
    DROP DATABASE IF EXISTS BikeShop;
END
GO

RAISERROR(N'Creating BikeShop', 0, 1) WITH NOWAIT;
CREATE DATABASE BikeShop;
