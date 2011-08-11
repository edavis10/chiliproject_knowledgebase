(function($) {
  KnowledgeBase = {
    registerAjaxIndicator: function() {
      $("#ajax-indicator").ajaxStart(function(){ $(this).show();  });
      $("#ajax-indicator").ajaxStop(function(){ $(this).hide();  });

    },

    registerKnowledgeBaseAddLightbox: function() {
      $('.knowledgebase-lightbox').live('click', function() {
        var journalId = $(this).attr('id').split('-').last();

        $('#dialog-window').
          hide().
          html('').
          load('/knowledge_bases/new?format=js&journal_id=' + journalId).
          dialog({
            title: "Add Knowledge Base Content",
            minWidth: 400,
            width: 850,
            buttons: {
              "Submit": function() {
                alert('TODO: Need to save');
              },
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
