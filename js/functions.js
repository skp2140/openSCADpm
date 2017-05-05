(function ($) {
   $('.btn-default').on('click', function (e) {
      e.preventDefault();
      var obj = $(this);

      obj.addClass('active');

      setTimeout(function () {
         obj.removeClass('active');
      }, 1500);
   });
  
   $(document).ready(function () {
  
      function searchName()
      {
         var search_url = "https://github.com/search?utf8=✓&q=ospm+";
         var pack_name = $('#search1').val();
         pack_name = pack_name.split(' ').join('+');
         pack_name = search_url.concat(pack_name);
         pack_name = pack_name.concat("&ref=simplesearch");
         window.location.href = pack_name;       
      }
      $('#hit1').click(function() {          
         searchName();
      });
       
      $('#nameSearch').submit(function(event) {
          event.preventDefault();
          searchName();
      });
       
      function searchRepos()
      {
         var search_url = "https://github.com/search?utf8=✓&q=topic%3Aopenscad-pm";
         var pack_name = $('#search2').val();
          
         if (pack_name)
         {      
             search_url = search_url.concat("+topic%3A");  
             pack_name = pack_name.split(' ').join('+topic%3A');   
             pack_name = search_url.concat(pack_name);
         }
         else
            pack_name = search_url;
         pack_name = pack_name.concat("&type=Repositories");
         window.location.href = pack_name;
      }
      $('#hit2').click(function() {
        searchRepos();
 
      });
       
      $('#catSearch').submit(function(event) {
          event.preventDefault();
          searchRepos();
      });
       
      function searchAut()
      {
         var search_url = "https://github.com/search?utf8=✓&q=topic%3Aopenscad-pm";
         var aut_name = $('#search3').val();
          
         if (aut_name)
         {      
             search_url = search_url.concat("+user%3A");  
             aut_name = aut_name.split(' ').join('+user%3A');   
             aut_name = search_url.concat(aut_name);
         }
         else
            aut_name = search_url;
         aut_name = aut_name.concat("&type=Repositories");
         window.location.href = aut_name;
      }
      $('#hit3').click(function() {
        searchAut();
 
      });
       
      $('#autSearch').submit(function(event) {
          event.preventDefault();
          searchAut();
      });


      var allPanels = $('.accordion > dd').hide();

      $('.accordion > dt > a').click(function() {
        $this = $(this);
        $target = $this.parent().next();

        if (!$target.hasClass('active')) {
          allPanels.removeClass('active').slideUp();
          $target.addClass('active').slideDown();
        }

        return false;
      });

      setTimeout(function () {
         $('body').addClass('dom-ready');
      }, 300);
   });
})(jQuery);



