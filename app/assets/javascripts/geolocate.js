$("document").ready(function() {
  $("#check-in-button").click(function() {
    event.preventDefault();

    x = navigator.geolocation;
    x.getCurrentPosition(success, failure);

    function success(position) {
      var mylat = position.coords.latitude;
      var mylong = position.coords.longitude;

      $("#check_in_latitude").attr("value", mylat);
      $("#check_in_longitude").attr("value", mylong);

      $("#new_check_in").submit();
    };

    function failure() {
      $("#left").append("<p> Failure!</p>")
    };
  });
});
