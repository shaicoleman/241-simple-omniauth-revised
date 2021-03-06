/*!
 * jQuery OAuth via popup window plugin
 *
 * @author  Nobu Funaki @nobuf
 *
 * Dual licensed under the MIT and GPL licenses:
 *   http://www.opensource.org/licenses/mit-license.php
 *   http://www.gnu.org/licenses/gpl.html
 */
(function($){
    //  inspired by DISQUS
    $.oauthpopup = function(options) {
        $('body').append('<div id="oauthpopup-overlay" style="background: rgba(0, 0, 0, 0.8); top: 0; left: 0; width:100%; height:100%; position:fixed; z-index:5000; display: none;"></div>');
        $('#oauthpopup-overlay').click(function() { $.oauthWindow.close(); });
        $('#oauthpopup-overlay').fadeIn(400);

        options = $.extend({
            width: 400,
            height: 460,
            path: $(this).attr('href'),
            windowName: 'ConnectWithOAuth', // should not include space for IE
            windowOptions: 'location=0,status=0',
            onClose: function() { window.location.reload(); }
        }, options);
        if (!options.path) {
            throw new Error("options.path must not be empty");
        }

        windowOptions = options.windowOptions + ',width=' + options.width +
                                                ',height=' + options.height +
                                                ',left=' + parseInt(($(window).width()-options.width)/2) +
                                                ',top=' + parseInt(($(window).height()-options.height)/2);

        if (typeof($.oauthWindow) !== 'undefined') { $.oauthWindow.close(); }
        $.oauthWindow = window.open(options.path, options.windowName, windowOptions);
        //try { $.oauthWindow.document.title = 'Please wait...'; } catch(e) {}
        var oauthInterval = window.setInterval(function(){
            if ($.oauthWindow.closed) {
                window.clearInterval(oauthInterval);
                $('#oauthpopup-overlay').remove();
                options.onClose();
            }
        }, 100);
        return false;
    };

    //bind to element and pop oauth when clicked
    $.fn.oauthpopup = function(options) {
        $(this).click($.oauthpopup.bind(this, options));
    };
})(jQuery);
