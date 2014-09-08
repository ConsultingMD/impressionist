TestApp::Application.routes.draw do
  resources :articles, :posts, :widgets, :dummy, :override
end
