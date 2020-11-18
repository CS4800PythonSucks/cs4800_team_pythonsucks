// Hide the post when favorite button is clicked
$(document).ready(function() {
    // Hide post when it is unfavorited in the favorites page
    $(".fav-btn").click(function() {
        $(".post-container[data-post=" + $(this).data("post") + "]").hide();
    })
});
