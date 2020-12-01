console.log("fucking tub graph");

window.chartColors = {
  red: "rgb(255, 99, 132)",
  orange: "rgb(255, 159, 64)",
  yellow: "rgb(255, 205, 86)",
  green: "rgb(75, 192, 192)",
  blue: "rgb(54, 162, 235)",
  purple: "rgb(153, 102, 255)",
  grey: "rgb(201, 203, 207)",
};

let seed = 42;
const randomScalingFactor = (min = -100, max = 100) => {
  min = min === undefined ? 0 : min;
  max = max === undefined ? 1 : max;
  seed = (seed * 9301 + 49297) % 233280;
  return Math.round(min + (seed / 233280) * (max - min));
};

// INITIALIZATION
var lineChartData = {
  labels: ["January", "February", "March", "April", "May", "June", "July"],
  datasets: [
    {
      label: "My First dataset",
      borderColor: window.chartColors.red,
      backgroundColor: window.chartColors.red,
      fill: false,
      data: [
        randomScalingFactor(),
        randomScalingFactor(),
        randomScalingFactor(),
        randomScalingFactor(),
        randomScalingFactor(),
        randomScalingFactor(),
        randomScalingFactor(),
      ],
      yAxisID: "y-axis-1",
    },
    {
      label: "My Second dataset",
      borderColor: window.chartColors.blue,
      backgroundColor: window.chartColors.blue,
      fill: false,
      data: [
        randomScalingFactor(),
        randomScalingFactor(),
        randomScalingFactor(),
        randomScalingFactor(),
        randomScalingFactor(),
        randomScalingFactor(),
        randomScalingFactor(),
      ],
      yAxisID: "y-axis-2",
    },
  ],
};

window.onload = function () {
  var ctx = document.getElementById("canvas").getContext("2d");
  window.myLine = Chart.Line(ctx, {
    data: lineChartData,
    options: {
      responsive: true,
      hoverMode: "index",
      stacked: false,
      title: {
        display: true,
        text: "Chart.js Line Chart - Multi Axis",
      },
      scales: {
        yAxes: [
          {
            type: "linear", // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
            display: true,
            position: "left",
            id: "y-axis-1",
          },
          {
            type: "linear", // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
            display: true,
            position: "right",
            id: "y-axis-2",

            // grid line settings
            gridLines: {
              drawOnChartArea: false, // only want the grid lines for one axis to show up
            },
          },
        ],
      },
    },
  });
};

document.getElementById("randomizeData").addEventListener("click", function () {
  lineChartData.datasets.forEach(function (dataset) {
    dataset.data = dataset.data.map(function () {
      return randomScalingFactor();
    });
  });

  window.myLine.update();
});
