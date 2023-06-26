CREATE   PROCEDURE [Admin].usp_manage_ForeignKeyDropAll
AS
BEGIN
	DECLARE @FKName VARCHAR(40);
	DECLARE @SchemaName VARCHAR(40);
	DECLARE @TableName VARCHAR(40);
	DECLARE @Query	VARCHAR(400);

	DECLARE My_Cursor CURSOR LOCAL FORWARD_ONLY
	FOR
		SELECT  obj.name AS FK_NAME,
			sch.name AS [schema_name],
			tab1.name AS [table]
		FROM sys.foreign_key_columns fkc
		INNER JOIN sys.objects obj
			ON obj.object_id = fkc.constraint_object_id
		INNER JOIN sys.tables tab1
			ON tab1.object_id = fkc.parent_object_id
		INNER JOIN sys.schemas sch
			ON tab1.schema_id = sch.schema_id
		INNER JOIN sys.columns col1
			ON col1.column_id = parent_column_id AND col1.object_id = tab1.object_id
		INNER JOIN sys.tables tab2
			ON tab2.object_id = fkc.referenced_object_id
		INNER JOIN sys.columns col2
			ON col2.column_id = referenced_column_id AND col2.object_id = tab2.object_id

	OPEN My_Cursor

	FETCH NEXT FROM My_Cursor
	INTO @FKName, @SchemaName, @TableName 

	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @Query = CONCAT('ALTER TABLE ', @SchemaName, '.', @TableName, ' DROP CONSTRAINT ', @FKName);
		PRINT @Query;
		EXECUTE (@Query);

		FETCH NEXT FROM My_Cursor
		INTO @FKName, @SchemaName, @TableName 

	END
	CLOSE My_Cursor;
	DEALLOCATE My_Cursor;
END;