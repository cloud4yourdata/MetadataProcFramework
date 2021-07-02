CREATE VIEW [load].[vwDataSourceMetaData]
AS
SELECT ds.Id AS dsId
    , ds.Name AS dsName
    ,REPLACE(COALESCE(ds.DataSetPropertiesMetaQuery, dst.DefaulDataSetPropertiesMetaQuery),
    '%%DataSourceId%%',ds.Id) AS metaQuery
FROM [load].[DataSource] AS ds
JOIN [load].[DataSourceType] AS dst
    ON dst.Id = ds.DataSourceTypeId
