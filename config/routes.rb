Rails.application.routes.draw do
  devise_for :administrators

  authenticated :administrator do
    root "credentials#index"
  end

  root "contexts#index"

  get "/landing", to: "application#landing", as: 'landing'
  get "/sign_out", to:"users#sign_out", as: "lti_user_sign_out"

  resources :check_ins, only: [:create, :destroy, :edit, :show]
  resources :contexts, only: [:index, :edit, :show]
  resources :credentials, only: [:index, :create, :destroy]
  resources :enrollments, only: []
  # resources :launches, except: :create
  resource  :launch, only: :create
  resources :resources, only: [:edit, :show]
  resource :user, only: [:edit, :show, :update]
end

# == Route Map
#
#                            Prefix Verb   URI Pattern                                                                       Controller#Action
#         new_administrator_session GET    /administrators/sign_in(.:format)                                                 devise/sessions#new
#             administrator_session POST   /administrators/sign_in(.:format)                                                 devise/sessions#create
#     destroy_administrator_session DELETE /administrators/sign_out(.:format)                                                devise/sessions#destroy
#        new_administrator_password GET    /administrators/password/new(.:format)                                            devise/passwords#new
#       edit_administrator_password GET    /administrators/password/edit(.:format)                                           devise/passwords#edit
#            administrator_password PATCH  /administrators/password(.:format)                                                devise/passwords#update
#                                   PUT    /administrators/password(.:format)                                                devise/passwords#update
#                                   POST   /administrators/password(.:format)                                                devise/passwords#create
# cancel_administrator_registration GET    /administrators/cancel(.:format)                                                  devise/registrations#cancel
#    new_administrator_registration GET    /administrators/sign_up(.:format)                                                 devise/registrations#new
#   edit_administrator_registration GET    /administrators/edit(.:format)                                                    devise/registrations#edit
#        administrator_registration PATCH  /administrators(.:format)                                                         devise/registrations#update
#                                   PUT    /administrators(.:format)                                                         devise/registrations#update
#                                   DELETE /administrators(.:format)                                                         devise/registrations#destroy
#                                   POST   /administrators(.:format)                                                         devise/registrations#create
#                              root GET    /                                                                                 credentials#index
#                                   GET    /                                                                                 credentials#index
#                         check_ins POST   /check_ins(.:format)                                                              check_ins#create
#                          check_in DELETE /check_ins/:id(.:format)                                                          check_ins#destroy
#                          contexts GET    /contexts(.:format)                                                               contexts#index
#                       credentials GET    /credentials(.:format)                                                            credentials#index
#                                   POST   /credentials(.:format)                                                            credentials#create
#                        credential DELETE /credentials/:id(.:format)                                                        credentials#destroy
#                            launch POST   /launch(.:format)                                                                 launches#create
#                          resource GET    /resources/:id(.:format)                                                          resources#show
#                rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                        active_storage/blobs#show
#              rails_blob_variation GET    /rails/active_storage/variants/:signed_blob_id/:variation_key/*filename(.:format) active_storage/variants#show
#                rails_blob_preview GET    /rails/active_storage/previews/:signed_blob_id/:variation_key/*filename(.:format) active_storage/previews#show
#                rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                       active_storage/disk#show
#         update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                               active_storage/disk#update
#              rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                    active_storage/direct_uploads#create
#
