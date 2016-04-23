// Hamburger menu

$( document ).ready(function(){
  $(".button-collapse").sideNav();

// Budget slider

var budgetSlider = document.getElementById('budget-burn');
var total = document.getElementById('total-budget').innerHTML;
var balance = document.getElementById('balance').innerHTML;
var remainder = balance / total;

var slider = function() {
  if (remainder >= 1) {
    budgetSlider.style = 'width: 100%'
  }
  else if (remainder >= 0.9) {
    budgetSlider.style = 'width: 90%'
  }
  else if (remainder >= 0.8) {
    budgetSlider.style = 'width: 80%'
  }
  else if (remainder >= 0.7) {
    budgetSlider.style = 'width: 70%'
  }
  else if (remainder >= 0.6) {
    budgetSlider.style = 'width: 60%'
  }
  else if (remainder >= 0.5) {
    budgetSlider.style = 'width: 50%'
  }
  else if (remainder >= 0.4) {
    budgetSlider.style = 'width: 40%'
  }
  else if (remainder >= 0.3) {
    budgetSlider.style = 'width: 30%'
  }
  else if (remainder >= 0.2) {
    budgetSlider.style = 'width: 20%'
  }
  else if (remainder >= 0.1) {
    budgetSlider.style = 'width: 10%'
  }
  else if (remainder <= 0) {
    budgetSlider.style = 'width: 0%'
  };
};

slider();

// Day slider

var daysSlider = document.getElementById('day-burn');
var totalDuration = document.getElementById('duration').innerHTML;
var daysLeft = document.getElementById('days-left').innerHTML;

var dayOfTrip = totalDuration - daysLeft;
var tripProgress = daysLeft / totalDuration;


var timeSlider = function() {
  if (tripProgress >= 1) {
    daysSlider.style = 'width: 100%'
  }
  else if (tripProgress >= 0.9) {
    daysSlider.style = 'width: 90%'
  }
  else if (tripProgress >= 0.8) {
    daysSlider.style = 'width: 80%'
  }
  else if (tripProgress >= 0.7) {
    daysSlider.style = 'width: 70%'
  }
  else if (tripProgress >= 0.6) {
    daysSlider.style = 'width: 60%'
  }
  else if (tripProgress >= 0.5) {
    daysSlider.style = 'width: 50%'
  }
  else if (tripProgress >= 0.4) {
    daysSlider.style = 'width: 40%'
  }
  else if (tripProgress >= 0.3) {
    daysSlider.style = 'width: 30%'
  }
  else if (tripProgress >= 0.2) {
    daysSlider.style = 'width: 20%'
  }
  else if (tripProgress >= 0.1) {
    daysSlider = 'width: 10%'
  }
  else {
    daysSlider.style = 'width: 0%'
  };
};

timeSlider();

});
