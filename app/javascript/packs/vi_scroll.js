// Vi style scrolling for webpage
$(document).ready(function() {
    const scrollStep = 50; // Number of pixels for a single 
    var lastScroll = 0; // Time of last scroll handled
    $(window).keydown(function(e) { // Scroll page down on j and up on k
        if (e.defaultPrevented) {
            return;
        }
        var now = Date.now();
        if (now - lastScroll > 10) {
            switch (e.key) {
            case "j":
                window.scrollBy({
                    top: scrollStep,
                    left: 0
                });
                lastScroll = now;
                break;
            case "k":
                window.scrollBy({
                    top: -scrollStep,
                    left: 0
                });
                lastScroll = now;
                break;
            default:
                return;
            }
        }
        e.preventDefault();
    });
});
