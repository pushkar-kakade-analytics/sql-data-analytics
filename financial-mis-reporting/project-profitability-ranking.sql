/*
Project:
Financial MIS Dashboard

Purpose:
Rank projects based on profitability performance.

Business Use Case:
Used to identify top-performing and underperforming projects.
*/

SELECT
    P.Project_Name,
    P.Region,
    P.Project_Manager,

    SUM(F.Revenue_Actual) AS Revenue,
    SUM(F.Project_Cost) AS Project_Cost,
    SUM(F.Profit) AS Profit,

    RANK() OVER (
        ORDER BY SUM(F.Profit) DESC
    ) AS Profit_Rank

FROM Fact_Financials F

INNER JOIN Dim_Project P
    ON F.Project_ID = P.Project_ID

GROUP BY
    P.Project_Name,
    P.Region,
    P.Project_Manager

ORDER BY
    Profit_Rank;
