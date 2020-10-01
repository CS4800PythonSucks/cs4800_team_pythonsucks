$(document).ready(function() {
    // Show modal when img is clicked
    $("#homeImg").click(function() {
        $("#homeModal").css("display", "block");
        $("#modalImg").attr("src", $(this).attr("src"));
        $("#caption").html($("#imgTitle").html());
    });
    // Hide modal when modal image is clicked
    $("#modalImg").click(function() {
        $("#homeModal").hide();
    });
});
