$(document).ready(function() {
    // Show modal when img is clicked
    $("img").click(function() {
        $("#modalDiv").css("display", "block");
        $("#modalImg").attr("src", $(this).attr("src"));
        $("#caption").text($(this).data("title"));
    });
    // Hide modal when modal image is clicked
    $("#modalImg").click(function() {
        $("#modalDiv").hide();
    });
});
