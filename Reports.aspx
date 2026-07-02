<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Reports.aspx.cs" Inherits="ProductPage.Admin.Reports" %>
<%@ Register Assembly="System.Web.DataVisualization" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h1>Sales Report</h1>
    <p>Summary of transactions for today.</p>

    <asp:SqlDataSource ID="SqlDataSourceCategories" runat="server"
        ConnectionString="<%$ ConnectionStrings:GrocerieShop %>"
        SelectCommand="SELECT CatId, CatTitle FROM Categories">
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceChart" runat="server"
        ConnectionString="<%$ ConnectionStrings:GrocerieShop %>"
        SelectCommand="
            SELECT S.ItemTitle, SUM(S.Quantity * S.Price) AS TotalSales
            FROM Sales S
            INNER JOIN Items I ON S.ItemTitle = I.ItemTitle
            WHERE S.Confirmed = 1
            AND (@CatId IS NULL OR @CatId = '' OR I.CatId = CONVERT(INT, @CatId))
            GROUP BY S.ItemTitle
            ORDER BY TotalSales DESC">
        <SelectParameters>
            <asp:ControlParameter Name="CatId" ControlID="ddlCategory" PropertyName="SelectedValue" DefaultValue="" ConvertEmptyStringToNull="false" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceDaily" runat="server"
        ConnectionString="<%$ ConnectionStrings:GrocerieShop %>"
        SelectCommand="
            SELECT S.ItemTitle, SUM(S.Quantity * S.Price) AS TotalSales
            FROM Sales S
            INNER JOIN Items I ON S.ItemTitle = I.ItemTitle
            WHERE S.Confirmed = 1
            AND CAST(S.SalesDate AS DATE) = CAST(GETDATE() AS DATE)
            AND (@CatId IS NULL OR @CatId = '' OR I.CatId = CONVERT(INT, @CatId))
            GROUP BY S.ItemTitle
            ORDER BY TotalSales DESC">
        <SelectParameters>
            <asp:ControlParameter Name="CatId" ControlID="ddlCategory" PropertyName="SelectedValue" DefaultValue="" ConvertEmptyStringToNull="false" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceWeekly" runat="server"
        ConnectionString="<%$ ConnectionStrings:GrocerieShop %>"
        SelectCommand="
            SELECT S.ItemTitle, SUM(S.Quantity * S.Price) AS TotalSales
            FROM Sales S
            INNER JOIN Items I ON S.ItemTitle = I.ItemTitle
            WHERE S.Confirmed = 1
            AND S.SalesDate >= DATEADD(DAY, -7, GETDATE())
            AND (@CatId IS NULL OR @CatId = '' OR I.CatId = CONVERT(INT, @CatId))
            GROUP BY S.ItemTitle
            ORDER BY TotalSales DESC">
        <SelectParameters>
            <asp:ControlParameter Name="CatId" ControlID="ddlCategory" PropertyName="SelectedValue" DefaultValue="" ConvertEmptyStringToNull="false" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceMonthly" runat="server"
        ConnectionString="<%$ ConnectionStrings:GrocerieShop %>"
        SelectCommand="
            SELECT S.ItemTitle, SUM(S.Quantity * S.Price) AS TotalSales
            FROM Sales S
            INNER JOIN Items I ON S.ItemTitle = I.ItemTitle
            WHERE S.Confirmed = 1
            AND MONTH(S.SalesDate) = MONTH(GETDATE())
            AND YEAR(S.SalesDate) = YEAR(GETDATE())
            AND (@CatId IS NULL OR @CatId = '' OR I.CatId = CONVERT(INT, @CatId))
            GROUP BY S.ItemTitle
            ORDER BY TotalSales DESC">
        <SelectParameters>
            <asp:ControlParameter Name="CatId" ControlID="ddlCategory" PropertyName="SelectedValue" DefaultValue="" ConvertEmptyStringToNull="false" />
        </SelectParameters>
    </asp:SqlDataSource>

    <br />

    <div style="background:white; padding:20px; border-radius:8px; border:1px solid #ddd;">
        <h4>Filter by Category:</h4>

        <asp:DropDownList ID="ddlCategory" runat="server" AutoPostBack="true"
            DataSourceID="SqlDataSourceCategories"
            DataTextField="CatTitle"
            DataValueField="CatId"
            AppendDataBoundItems="true">
            <asp:ListItem Text="All Categories" Value="" Selected="True" />
        </asp:DropDownList>

        <br /><br />

        <h3>Top Selling Products</h3>

        <asp:Chart ID="SalesChart" runat="server" Width="700px" Height="400px" DataSourceID="SqlDataSourceChart">
            <Series>
                <asp:Series Name="PieSeries" ChartType="Pie"
                    XValueMember="ItemTitle"
                    YValueMembers="TotalSales"
                    IsValueShownAsLabel="true"
                    Label="#PERCENT"
                    LegendText="#VALX" />
            </Series>
            <ChartAreas>
                <asp:ChartArea Name="ChartArea1" />
            </ChartAreas>
            <Legends>
                <asp:Legend Enabled="true" />
            </Legends>
        </asp:Chart>

        <br /><br />

        <h3>Today's Sales</h3>

        <asp:Chart ID="DailyChart" runat="server" Width="750px" Height="400px" DataSourceID="SqlDataSourceDaily">
            <Series>
                <asp:Series Name="DailySeries" ChartType="Column"
                    XValueMember="ItemTitle"
                    YValueMembers="TotalSales"
                    IsValueShownAsLabel="true" />
            </Series>
            <ChartAreas>
                <asp:ChartArea Name="ChartArea1" />
            </ChartAreas>
        </asp:Chart>

        <br /><br />

        <h3>Weekly Sales</h3>

        <asp:Chart ID="WeeklyChart" runat="server" Width="750px" Height="400px" DataSourceID="SqlDataSourceWeekly">
            <Series>
                <asp:Series Name="WeeklySeries" ChartType="Column"
                    XValueMember="ItemTitle"
                    YValueMembers="TotalSales"
                    IsValueShownAsLabel="true" />
            </Series>
            <ChartAreas>
                <asp:ChartArea Name="ChartArea1" />
            </ChartAreas>
        </asp:Chart>

        <br /><br />

        <h3>Monthly Sales</h3>

        <asp:Chart ID="MonthlyChart" runat="server" Width="750px" Height="400px" DataSourceID="SqlDataSourceMonthly">
            <Series>
                <asp:Series Name="MonthlySeries" ChartType="Column"
                    XValueMember="ItemTitle"
                    YValueMembers="TotalSales"
                    IsValueShownAsLabel="true" />
            </Series>
            <ChartAreas>
                <asp:ChartArea Name="ChartArea1" />
            </ChartAreas>
        </asp:Chart>

        <br />

        <div style="text-align:right; font-weight:bold; font-size:18px;">
            <asp:Label ID="lblGrandTotal" runat="server" Text="RM 0.00"></asp:Label>
        </div>
    </div>

</asp:Content>