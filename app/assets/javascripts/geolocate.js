$("document").ready(function() {
  $(".new-check-in-form").click(function() {
    event.preventDefault();
    const form = $(this)
    x = navigator.geolocation;
    x.getCurrentPosition(success, failure);

    function success(position) {
      var mylat = position.coords.latitude;
      var mylong = position.coords.longitude;

      $("#check_in_latitude").attr("value", mylat);
      $("#check_in_longitude").attr("value", mylong);

      form.submit();
    };

    function failure() {
      $("#left").append("<p> Failure!</p>")
      form.submit();
    };
  });
});
