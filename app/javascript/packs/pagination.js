$(document).ready(function() {
    if ($('#infinite-scroll').length > 0) {
        $(window).scroll(function() {
            more_posts_url = $('.pagination .next_page a').attr('href');
            if (more_posts_url && $(window).scrollTop() > $(document).height() - $(window).height() - 100) {
                $('.pagination').html('<img src="/assets/ajax-loader.gif" alt="Loading..." title="Loading..." />');
                jQuery.ajax({
                    url: more_posts_url,
                    dataType: 'script',
                    cache: true,
                });
            }
        });
    }
});
