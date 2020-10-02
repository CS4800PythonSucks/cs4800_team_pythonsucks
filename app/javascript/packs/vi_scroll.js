// Vi style scrolling for webpage
$(document).ready(function() {
    const scrollStep = 1; // Number of pixels for a single 
    const keyAction = {
        j: window.scrollBy(0, scrollStep), // Scroll down
        k: window.scrollBy(0, -scrollStep) // Scroll up
    };
    $(window).keypress(function(e) {
        var key = e.which;
        if (!(key in keyAction)) return;
        keyAction[key]();
    });
});
