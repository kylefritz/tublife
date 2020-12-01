import axios from "axios";
import moment from "moment";
import _ from "lodash";
import Chart from "chart.js";
require("chartjs-plugin-zoom");

const makeChart = (city, series) => {
  var ctx = document.getElementById(city).getContext("2d");

  const weather = series.filter(({ name }) => name === "Weather")[0].data;
  const rest = series
    .filter(({ name }) => name !== "Weather")
    .map(({ name, data, color }) => {
      return {
        label: name,
        yAxisID: "tub_temp",
        borderColor: chartColor(color),
        backgroundColor: chartColor(color),
        fill: false,
        data: makeTimeData(data),
        type: name.match(/pump/i) ? "bar" : "line",
      };
    });

  const data = {
    datasets: [
      {
        label: "Weather",
        yAxisID: "air_temp",
        borderColor: chartColor("blue"),
        fill: false,
        data: makeTimeData(weather),
      },
      ...rest,
    ],
  };
  // debugger;
  return Chart.Line(ctx, {
    data,
    options: {
      responsive: false,
      hoverMode: "index",
      stacked: false,
      title: {
        display: true,
        text: _.capitalize(city),
      },
      scales: {
        xAxes: [
          {
            type: "time",
            distribution: "series",
            offset: true,
            ticks: {
              source: "data",
              autoSkip: true,
              autoSkipPadding: 75,
              maxRotation: 0,
              sampleSize: 100,
            },
          },
        ],
        yAxes: [
          { id: "tub_temp", ticks: { min: 85, max: 110 } },
          {
            id: "air_temp",
            ticks: { min: 30, max: 70 },
            position: "right",
            // only want the grid lines for one axis to show up
            gridLines: { drawOnChartArea: false },
          },
        ],
      },
      plugins: {
        zoom: {
          pan: {
            enabled: true,
            mode: "xy",
          },
          zoom: {
            enabled: true,
            // drag: true,
            mode: "xy",
          },
        },
      },
    },
  });
};

let charts = [];
window.onload = () => {
  axios.get("/readings.json").then((response) => {
    const { baltimore, richmond } = response.data;
    charts = [
      makeChart("baltimore", baltimore),
      makeChart("richmond", richmond),
    ];
  });

  const footer = document.getElementById("footer");
  footer.remove();

  const toolbar = document.getElementById("toolbar");
  toolbar.appendChild(footer.children[0]);
};

document.getElementById("reset").addEventListener("click", function () {
  charts.map((c) => c.resetZoom());
});

const chartColor = (color) => {
  const chartColors = {
    red: "rgb(255, 99, 132)",
    orange: "rgb(255, 159, 64)",
    yellow: "rgb(255, 205, 86)",
    green: "rgb(75, 192, 192)",
    blue: "rgb(54, 162, 235)",
    purple: "rgb(153, 102, 255)",
    grey: "rgb(201, 203, 207)",
  };
  return chartColors[color] || color;
};

const makeTimeData = (data) =>
  data.map(([t, y]) => ({ t: moment(t).valueOf(), y }));
