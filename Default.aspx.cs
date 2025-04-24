using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;
using System.Web.UI;
using System.Web.UI.DataVisualization.Charting;

namespace TradingEconomics_CarlWebDemo
{
    public partial class _Default : Page
    {
        protected async void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var earnings = await FetchEarningsAsync(); // API call
                gvEarningsModal.DataSource = earnings;
                gvEarningsModal.DataBind();

                PopulateCharts(earnings);
            }
        }

        public class Earning
        {
            public string Symbol { get; set; }
            public string Name { get; set; }
            public string Country { get; set; }
            public string Type { get; set; }
            public DateTime Date { get; set; }
            public string Actual { get; set; }
            public string Forecast { get; set; }
            public string Previous { get; set; }
            public string FiscalTag { get; set; }
            public string FiscalReference { get; set; }
            public string CalendarReference { get; set; }
        }

        private async Task<List<Earning>> FetchEarningsAsync()
        {
            var earningsList = new List<Earning>();

            try
            {
                using (HttpClient client = new HttpClient())
                {
                    client.BaseAddress = new Uri("https://api.tradingeconomics.com/");
                    client.DefaultRequestHeaders.Accept.Clear();
                    client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                    client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Client", "guest:guest");

                    HttpResponseMessage response = await client.GetAsync("earnings?c=guest:guest");
                    string json = await response.Content.ReadAsStringAsync();

                    if (response.IsSuccessStatusCode)
                    {
                        earningsList = JsonConvert.DeserializeObject<List<Earning>>(json);
                    }
                    else
                    {
                        lblDebug.Text = $"API Error: {response.StatusCode} - {response.ReasonPhrase}";
                    }
                }
            }
            catch (Exception ex)
            {
                lblDebug.Text = $"Exception: {ex.Message}";
            }

            return earningsList;
        }

        private void PopulateCharts(List<Earning> earningsList)
        {
            // Chart 1: Count per Country
            var countries = earningsList
                .GroupBy(e => e.Country)
                .Select(g => new { Country = g.Key, Count = g.Count() });

            ChartByCountry.Series["CountrySeries"].Points.Clear();
            foreach (var item in countries)
            {
                ChartByCountry.Series["CountrySeries"].Points.AddXY(item.Country, item.Count);
            }

            // Chart 2: Forecast values by Date (first 10 entries for simplicity)
            var forecasts = earningsList
                .Where(e => !string.IsNullOrEmpty(e.Forecast))
                .Take(10);

            ChartByForecast.Series["ForecastSeries"].Points.Clear();
            foreach (var item in forecasts)
            {
                if (double.TryParse(item.Forecast, out double val))
                {
                    ChartByForecast.Series["ForecastSeries"].Points.AddXY(item.Date.ToShortDateString(), val);
                }
            }

            // Chart 3: Actual values by Date (first 10 entries)
            var actuals = earningsList
                .Where(e => !string.IsNullOrEmpty(e.Actual))
                .Take(10);

            ChartByDate.Series["DateSeries"].Points.Clear();
            foreach (var item in actuals)
            {
                if (double.TryParse(item.Actual, out double val))
                {
                    ChartByDate.Series["DateSeries"].Points.AddXY(item.Date.ToShortDateString(), val);
                }
            }

            // Chart 4: Distribution by Type
            var types = earningsList
                .GroupBy(e => e.Type)
                .Select(g => new { Type = g.Key, Count = g.Count() });

            ChartByType.Series["TypeSeries"].Points.Clear();
            foreach (var item in types)
            {
                ChartByType.Series["TypeSeries"].Points.AddXY(item.Type, item.Count);
            }
        }
      
    }
}