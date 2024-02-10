CREATE OR REPLACE PROCEDURE GEN_SALARY_HISTOGRAM
        (start_value DECIMAL(9, 2), end_value DECIMAL(9, 2), bin_numbers INT)
        LANGUAGE SQL
BEGIN
        DECLARE bin_width DECIMAL(9, 2);
        SET bin_width = (end_value - start_value) / bin_numbers;

        DELETE FROM SALARY_HISTOGRAM;
        INSERT INTO SALARY_HISTOGRAM (BINNUM, FREQUENCY, BINSTART, BINEND)
        SELECT BINNUM,
        COUNT(*) AS FREQUENCY,
        (BINNUM - 1) * bin_width + start_value AS BINSTART,
        (BINNUM * bin_width) + start_value AS BINEND
        FROM (
                SELECT TRUNC((SALARY - start_value) / bin_width) + 1 AS BINNUM
                FROM EMPLOYEE
                WHERE SALARY >= start_value AND SALARY < end_value
        ) AS TEMP
        GROUP BY BINNUM;
END;
@