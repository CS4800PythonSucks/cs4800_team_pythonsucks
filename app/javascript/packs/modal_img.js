$(document).ready(function() {
    // Show modal when img is clicked
    $("#postImg").click(function() {
        $("#modalDiv").css("display", "block");
        $("#modalImg").attr("src", $(this).attr("src"));
        $("#caption").text($(this).data("title").replace(/_/g, " "));
    });
    // Hide modal when modal image is clicked
    $("#modalImg").click(function() {
        $("#modalDiv").hide();
    });
});
