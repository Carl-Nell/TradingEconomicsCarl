<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="TradingEconomics_CarlWebDemo._Default" Async="true" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
   
    <style>
        .card {
            margin: 20px 0;
            padding: 20px;
            border-radius: 30px;
            box-shadow: 0 10px 15px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s;
            width:200px;
        }

        .card:hover {
            transform: scale(1.2);
        }

        /* Disable hover effect on screens smaller than 576px */
        @media (max-width: 576px) {
            .card:hover {
                transform: none; /* Remove the scaling effect */
            }
        }

        .btn_teal {            
            color:black;
            background:teal;
            border-top:solid;
            border-left:solid;
            border-bottom:none;
            border-right:none;
            border-radius:20px;
            border-color:darkslategray;
            padding:10px;
        }

        .btn_teal:hover {        
            color:teal;
            border-top:none;
            border-left:none;
            border-bottom:solid;
            border-right:solid;
            border-color:darkslategray;
        }

    </style>
    <div class="jumbotron" style="margin-top:65px">
        <h1>Trading Economics</h1>
        <p class="lead">A small web sample to view data for Trading Economics</p>
        <p>Created by Carl &raquo;</p>
    </div>
    
    
    <!-- Cards-->
    <div class="row justify-content-center" style="margin-top: 60px;"> 
        <div class="col-sm-4 mb-4">
            <div class="card" style="width: 300px; height:300px;">
                <div class="card-body text-center">
                    <h2 class="card-title">View Earnings Calendar</h2><br />
                    <a class="btn_teal btn" style="cursor:pointer; width:200px;" data-toggle="modal" data-target="#earningsModal">View &raquo;</a>
                </div>
            </div>
        </div>
    </div>
    

    <div class="modal fade " id="earningsModal" tabindex="-1" aria-labelledby="earningsModalLabel" aria-hidden="true">
          <div class="modal-dialog modal-xl modal-dialog-scrollable" style="width:80%">
            <div class="modal-content">
              <div class="modal-header">
                <h2 class="modal-title" id="earningsModalLabel">Earnings Calendar</h2>
                <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close">
                                
                            </button>
              </div>
              <div class="modal-body">
                <asp:GridView ID="gvEarningsModal" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered">
                    <Columns>
                        <asp:BoundField DataField="Date" HeaderText="Date" DataFormatString="{0:yyyy-MM-dd}" />
                        <asp:BoundField DataField="Symbol" HeaderText="Symbol" />
                        <asp:BoundField DataField="Name" HeaderText="Name" />
                        <asp:BoundField DataField="Type" HeaderText="Type" />
                        <asp:BoundField DataField="Country" HeaderText="Country" />
                        <asp:BoundField DataField="Actual" HeaderText="Actual" />
                        <asp:BoundField DataField="Forecast" HeaderText="Forecast" />
                        <asp:BoundField DataField="Previous" HeaderText="Previous" />
                        <asp:BoundField DataField="FiscalTag" HeaderText="FiscalTag" />
                        <asp:BoundField DataField="FiscalReference" HeaderText="FiscalReference" />
                        <asp:BoundField DataField="CalendarReference" HeaderText="CalendarReference" />
                    </Columns>
                </asp:GridView>
                  <!-- Charts   -->
                  <div style="text-align:center">
                  <asp:Chart ID="ChartByCountry" runat="server" Width="400" Height="300">
                        <Series>
                            <asp:Series Name="CountrySeries" ChartType="Column" />
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="MainArea" />
                        </ChartAreas>
                    </asp:Chart>

                    <asp:Chart ID="ChartByForecast" runat="server" Width="400" Height="300">
                        <Series>
                            <asp:Series Name="ForecastSeries" ChartType="Line" />
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="MainArea" />
                        </ChartAreas>
                    </asp:Chart>

                    <asp:Chart ID="ChartByDate" runat="server" Width="400" Height="300">
                        <Series>
                            <asp:Series Name="DateSeries" ChartType="Area" />
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="MainArea" />
                        </ChartAreas>
                    </asp:Chart>

                    <asp:Chart ID="ChartByType" runat="server" Width="400" Height="300">
                        <Series>
                            <asp:Series Name="TypeSeries" ChartType="Pie" />
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="MainArea" />
                        </ChartAreas>
                    </asp:Chart>
                 </div>
              </div>
            </div>
          </div>        
        </div>  
    <asp:Label runat="server" ID="lblDebug" ></asp:Label>


   
</asp:Content>
