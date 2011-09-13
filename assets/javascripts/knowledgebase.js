(function($) {
  KnowledgeBase = {
    registerAjaxIndicator: function() {
      $("#ajax-indicator").ajaxStart(function(){ $(this).show().css('z-index', '9999'); });
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
            show: "fadeIn",
            hide: "fadeOut",
            dialogClass: "knowledgebase",
            buttons: {
              "Submit": function() {
                $('#knowledgebase-form').submit();
              },
              "Cancel": function() {
                $(this).dialog("close");
              }
            }});

        return false;

      });
    },

    registerKnowledgeBaseAddForm: function() {
      $('#knowledgebase-form').live('submit', function() {
        $('#knowledgebase-errors').hide().html('');

        $(this).ajaxSubmit({
          dataType: 'json',
          success: function(data, textStatus, xhr) {
            var messageUrl = xhr.getResponseHeader('Location');
            $('#knowledgebase-form').
              html('<div class="flash notice">Knowledge base post created at <a href="' + messageUrl + '">' + messageUrl +'</a>.</div>');

            // Change buttons
            $('#dialog-window').dialog({ buttons: {
              "Close": function() {
                $(this).dialog("close");
              }}});

          },
          error: function(jqXHR, textStatus, errorThrown) {
            var errors = $.parseJSON(jqXHR.responseText);
            $.each(errors.errors, function(index, value) {
              $('#knowledgebase-errors').append(value + "<br />");
            });
            $('#knowledgebase-errors').show();
          }

        });

        return false;
      });
    },

    initialize: function() {
      this.registerKnowledgeBaseAddLightbox();
      this.registerKnowledgeBaseAddForm();

      $(document).ready(function() {
        KnowledgeBase.initializeAfterDomLoaded();
      });
    },

    initializeAfterDomLoaded: function() {
      this.registerAjaxIndicator();
    },
  };

  KnowledgeBase.initialize();
})(jQuery)
