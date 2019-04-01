document.addEventListener("turbolinks:load", function() {
  $(".details-toggle").click(function() {
    $(this).children(".rotating-icon-wrapper").toggleClass("rotate-180");
  });
});
