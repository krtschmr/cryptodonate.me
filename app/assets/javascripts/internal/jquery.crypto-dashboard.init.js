/**
 * Theme: Metrica - Responsive Bootstrap 4 Admin Dashboard
 * Author: Mannatthemes
 * Dashboard Js
 */

var ts2 = 1484418600000;
    var dates = [];    
    var spikes = [5, -5, 3, -3, 8, -8]
    for (var i = 0; i < 120; i++) {
      ts2 = ts2 + 86400000;
      var innerArr = [ts2, dataSeries[1][i].value];
      dates.push(innerArr)
    }


    var options = {
      chart: {
        type: 'area',
        stacked: false,
        height: 345,
        zoom: {
          type: 'x',
          enabled: true
        },
        toolbar: {
          show: false,
          autoSelected: 'zoom'
        }
      },
      colors: ['#4d79f6'],
      dataLabels: {
        enabled: false
      },
      series: [{
        name: 'Bitcoin',
        data: dates
      }],
      markers: {
        size: 0,
      },
      // title: {
      //   text: 'Stock Price Movement',
      //   align: 'left'
      // },
      fill: {
        type: 'gradient',
        gradient: {
          shadeIntensity: 1,
          inverseColors: true,
          opacityFrom: 0.5,
          opacityTo: 0,
          stops: [0, 90, 100]
        },
      },
      yaxis: {
        min: 20000000,
        max: 250000000,
        labels: {
          formatter: function (val) {
            return "$" + (val / 1000000).toFixed(0);
          },
        },
        title: {
          text: 'Price'
        },
      },
      xaxis: {
        type: 'datetime',
        axisBorder: {
          show: true,
          color: '#bec7e0',
        },  
        axisTicks: {
          show: true,
          color: '#bec7e0',
        },    
      },

      tooltip: {
        shared: false,
        y: {
          formatter: function (val) {
            return "$" + (val / 1000000).toFixed(0)
          }
        }
      }
    }

    var chart = new ApexCharts(
      document.querySelector("#crypto_dash_main"),
      options
    );

    chart.render();



 // Donut 

 //Animating a Donut with Svg.animate

 var chart = new Chartist.Pie('#animating-donut', {
  series: [20, 20, 20, 20, 20],
  labels: [1, 2, 3, 4, 5]
}, {
  donut: true,
  showLabel: false,
  donutWidth: 15,
  plugins: [
  Chartist.plugins.tooltip()
  ]
});

chart.on('draw', function(data) {
  if(data.type === 'slice') {
  // Get the total path length in order to use for dash array animation
  var pathLength = data.element._node.getTotalLength();

  // Set a dasharray that matches the path length as prerequisite to animate dashoffset
  data.element.attr({
      'stroke-dasharray': pathLength + 'px ' + pathLength + 'px'
  });

  // Create animation definition while also assigning an ID to the animation for later sync usage
  var animationDefinition = {
      'stroke-dashoffset': {
      id: 'anim' + data.index,
      dur: 1000,
      from: -pathLength + 'px',
      to:  '0px',
      easing: Chartist.Svg.Easing.easeOutQuint,
      // We need to use `fill: 'freeze'` otherwise our animation will fall back to initial (not visible)
      fill: 'freeze'
      }
  };

  // If this was not the first slice, we need to time the animation so that it uses the end sync event of the previous animation
  if(data.index !== 0) {
      animationDefinition['stroke-dashoffset'].begin = 'anim' + (data.index - 1) + '.end';
  }

  // We need to set an initial value before the animation starts as we are not in guided mode which would do that for us
  data.element.attr({
      'stroke-dashoffset': -pathLength + 'px'
  });

  // We can't use guided mode as the animations need to rely on setting begin manually
  // See http://gionkunz.github.io/chartist-js/api-documentation.html#chartistsvg-function-animate
  data.element.animate(animationDefinition, false);
  }
});

// For the sake of the example we update the chart every time it's created with a delay of 8 seconds
chart.on('created', function() {
  if(window.__anim21278907124) {
  clearTimeout(window.__anim21278907124);
  window.__anim21278907124 = null;
  }
  window.__anim21278907124 = setTimeout(chart.update.bind(chart), 10000);
});