$(document).ready(function() {

$(".fancybox")
 .attr('rel', 'gallery')
 .attr('data-fancybox-width', "300")
 .attr('data-fancybox-height', "300")
 .fancybox({
    openEffect  : 'none',
    nextEffect  : 'fade',
    prevEffect  : 'fade',
    closeEffect : 'none',
    margin      : [15, 15, 40, 15],
    autosize : false,
    beforeLoad : function() {
      this.width  = parseInt(this.element.data('fancybox-width'));
      this.height = parseInt(this.element.data('fancybox-height'));
    },
    beforeShow: function () {

      $('<div class="watermark"></div>')
          .bind("contextmenu", function (e) {
              return false;
          })
          .prependTo( $.fancybox.inner );
         }
     });

 });
