import axios from "axios";
import moment from "moment";
import _ from "lodash";
import Chart from "chart.js";
require("chartjs-plugin-zoom");

const isMobile = (() => {
  try {
    document.createEvent("TouchEvent");
    return true;
  } catch {
    return false;
  }
})();

function makeSubtitle({ weather, rest }) {
  try {
    const currentWeather = weather[weather.length - 1][1];
    const temps = rest
      .filter(({ label }) => label != "Pump")
      .map(({ label, data }) => `${label} ${data[data.length - 1].y}°`)
      .join(", ");

    return `${currentWeather}°, ${temps}`;
  } catch ({ message }) {
    console.error("error making subtitle", message);
  }
}
function formatDegrees(v) {
  return Math.round(v) + "°F";
}

const makeChart = (city, series) => {
  var ctx = document.getElementById(city).getContext("2d");

  const weather = series.filter(({ name }) => name === "Weather")[0].data;
  const rest = series
    .filter(({ name }) => name !== "Weather")
    .map(({ name, data, color }) => {
      const opts = name.match(/pump/i)
        ? {
            fill: "origin",
            pointRadius: 0,
            lineTension: 0,
            spanGaps: false,
          }
        : {
            fill: false,
          };

      return {
        label: name,
        yAxisID: "tub_temp",
        borderColor: chartColor(color),
        backgroundColor: chartColor(color),
        ...opts,
        data: makeTimeData(data),
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
  const title = _.capitalize(city) + "\n" + makeSubtitle({ weather, rest });
  return Chart.Line(ctx, {
    data,
    options: {
      responsive: false,
      hoverMode: "index",
      stacked: false,
      title: {
        display: true,
        text: title,
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
          {
            id: "tub_temp",
            position: "right",
            ticks: {
              min: 85,
              max: 110,
              callback: formatDegrees,
            },
            scaleLabel: {
              display: true,
              labelString: "Tub",
            },
          },
          {
            id: "air_temp",
            position: "right",
            ticks: {
              min: 30,
              max: 70,
              callback: formatDegrees,
            },
            // only want the grid lines for one axis to show up
            gridLines: { drawOnChartArea: false },
            scaleLabel: {
              display: true,
              labelString: "Outside",
            },
          },
        ],
      },
      plugins: {
        zoom: {
          pan: {
            enabled: !isMobile,
            mode: "xy",
          },
          zoom: {
            enabled: !isMobile,
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
      // makeChart("richmond", richmond),
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
