/*
Project:
Financial MIS Dashboard

Purpose:
Track monthly revenue trends and rolling revenue movement.

Business Use Case:
Used for executive trend analysis and business growth monitoring.
*/

SELECT
    F.Month_End_Date,
    P.Region,

    SUM(F.Revenue_Actual) AS Monthly_Revenue,

    SUM(SUM(F.Revenue_Actual)) OVER (
        PARTITION BY P.Region
        ORDER BY F.Month_End_Date
    ) AS Running_Revenue,

    AVG(SUM(F.Revenue_Actual)) OVER (
        PARTITION BY P.Region
        ORDER BY F.Month_End_Date
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS Rolling_3_Month_Average

FROM Fact_Financials F

INNER JOIN Dim_Project P
    ON F.Project_ID = P.Project_ID

GROUP BY
    F.Month_End_Date,
    P.Region

ORDER BY
    P.Region,
    F.Month_End_Date;
