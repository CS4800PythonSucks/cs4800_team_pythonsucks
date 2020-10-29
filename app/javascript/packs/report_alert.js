// Display the report alert when the report button is clicked
$(document).ready(function() {
    // Show alert when button is clicked
    $(".report-btn").click(function() {
        $(".report-alert[data-post=" + $(this).data("post") + "]").show();
    })
});
