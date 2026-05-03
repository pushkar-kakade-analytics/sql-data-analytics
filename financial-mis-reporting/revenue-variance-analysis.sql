/*
Project:
Financial MIS Dashboard

Purpose:
Analyze Actual Revenue vs AOP Revenue and calculate variance metrics
for executive MIS reporting.

Business Use Case:
Leadership teams use this analysis to monitor business performance,
identify underperforming projects, and track financial achievement
against planned targets.
*/

SELECT
    F.Month_End_Date,
    P.SBG,
    P.SBU,
    P.BU,
    P.Region,
    P.Project_Name,

    SUM(F.Revenue_Actual) AS Revenue_Actual,
    SUM(F.Revenue_AOP) AS Revenue_AOP,

    SUM(F.Revenue_Actual) - SUM(F.Revenue_AOP)
        AS Revenue_Variance,

    CASE
        WHEN SUM(F.Revenue_AOP) = 0 THEN 0
        ELSE
            (
                SUM(F.Revenue_Actual) - SUM(F.Revenue_AOP)
            ) * 100.0
            / SUM(F.Revenue_AOP)
    END AS Revenue_Variance_Percentage

FROM Fact_Financials F

INNER JOIN Dim_Project P
    ON F.Project_ID = P.Project_ID

GROUP BY
    F.Month_End_Date,
    P.SBG,
    P.SBU,
    P.BU,
    P.Region,
    P.Project_Name

ORDER BY
    F.Month_End_Date,
    Revenue_Actual DESC;
