(function($) {
  KnowledgeBase = {
    registerAjaxIndicator: function() {
      $("#ajax-indicator").ajaxStart(function(){ $(this).show();  });
      $("#ajax-indicator").ajaxStop(function(){ $(this).hide();  });

    },

    registerKnowledgeBaseAddLightbox: function() {
      $('.knowledgebase-lightbox').live('click', function() {
        $('#dialog-window').
          hide().
          html('').
          load('/issues/91.json').
          dialog({
            title: "Add Knowledge Base Content",
            minWidth: 400,
            width: 800,
            buttons: {
              "Cancel": function() {
                $(this).dialog("close");
              }
            }});

        return false;

      });
    },

    initialize: function() {
      this.registerAjaxIndicator();
      this.registerKnowledgeBaseAddLightbox();
    }
  };

  KnowledgeBase.initialize();
})(jQuery)
