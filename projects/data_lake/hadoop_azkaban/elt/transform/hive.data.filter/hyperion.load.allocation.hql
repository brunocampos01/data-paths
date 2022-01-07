CREATE VIEW staging.hyperion_allocation AS
SELECT
	 COALESCE(T3.MEMBER, T2.MEMBER, T1.MEMBER)	AS CDALOCACAO
	,T1.MEMBER 									AS DEALOCACAONIVEL1
	,COALESCE(T2.MEMBER, T1.MEMBER) 			AS DEALOCACAONIVEL2
	,COALESCE(T3.MEMBER, T2.MEMBER, T1.MEMBER) 	AS DEALOCACAONIVEL3
FROM raw.hyperion_metadados T1
LEFT JOIN raw.hyperion_metadados T2 ON T2.DIMENSION = T1.DIMENSION AND T2.APP = T1.APP AND T2.PARENT = T1.MEMBER
LEFT JOIN raw.hyperion_metadados T3 ON T3.DIMENSION = T2.DIMENSION AND T3.APP = T2.APP AND T3.PARENT = T2.MEMBER
WHERE T1.DIMENSION = 'ALOCACAO' AND T1.APP = 'FINANCAS' AND T1.PARENT = 'ALOCACAO'