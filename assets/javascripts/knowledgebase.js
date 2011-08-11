(function($) {
  KnowledgeBase = {
    registerAjaxIndicator: function() {
      $("#ajax-indicator").ajaxStart(function(){ $(this).show();  });
      $("#ajax-indicator").ajaxStop(function(){ $(this).hide();  });

    },

    initialize: function() {
      this.registerAjaxIndicator();
    }
  };

  KnowledgeBase.initialize();
})(jQuery)
