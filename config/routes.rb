ActionController::Routing::Routes.draw do |map|
  map.resources :knowledge_bases, :only => [:new, :create]
end
