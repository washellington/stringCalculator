Rails.application.routes.draw do

  get 'calculators', to: 'calculators#index'
  
  root 'calculators#index'
end
