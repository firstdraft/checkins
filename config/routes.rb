# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :administrators

  authenticated :administrator do
    root "credentials#index"
  end

  root "resources#index"

  get "/landing", to: "application#landing", as: "landing"
  get "/sign_out", to: "users#sign_out", as: "lti_user_sign_out"
  get "/config" => "launches#xml_config"

  constraints(->(request) { request.host != "checkins.firstdraft.com" }) do
    get "/teacher" => "resources#teacher_backdoor"
    get "/student" => "resources#student_backdoor"
  end

  resources :attendances, only: %i[] do
    patch "transition"
  end
  resources :comments, only: %i[create]
  resources :contexts, only: %i[edit update show]
  resources :credentials, only: %i[index create destroy]
  resources :enrollments, only: []
  resource  :launch, only: :create
  resources :resources, only: %i[edit update show index] do
    resources :meetings, only: %i[index show edit update destroy new create]
  end
  resources :submissions, only: %i[] do
    member do
      put "resubmit"
    end
  end
  resource :user, only: %i[edit show update]
end

# rubocop:disable Metrics/LineLength

# == Route Map
#
#                            Prefix Verb   URI Pattern                                                                              Controller#Action
#         new_administrator_session GET    /administrators/sign_in(.:format)                                                        devise/sessions#new
#             administrator_session POST   /administrators/sign_in(.:format)                                                        devise/sessions#create
#     destroy_administrator_session DELETE /administrators/sign_out(.:format)                                                       devise/sessions#destroy
#        new_administrator_password GET    /administrators/password/new(.:format)                                                   devise/passwords#new
#       edit_administrator_password GET    /administrators/password/edit(.:format)                                                  devise/passwords#edit
#            administrator_password PATCH  /administrators/password(.:format)                                                       devise/passwords#update
#                                   PUT    /administrators/password(.:format)                                                       devise/passwords#update
#                                   POST   /administrators/password(.:format)                                                       devise/passwords#create
# cancel_administrator_registration GET    /administrators/cancel(.:format)                                                         devise/registrations#cancel
#    new_administrator_registration GET    /administrators/sign_up(.:format)                                                        devise/registrations#new
#   edit_administrator_registration GET    /administrators/edit(.:format)                                                           devise/registrations#edit
#        administrator_registration PATCH  /administrators(.:format)                                                                devise/registrations#update
#                                   PUT    /administrators(.:format)                                                                devise/registrations#update
#                                   DELETE /administrators(.:format)                                                                devise/registrations#destroy
#                                   POST   /administrators(.:format)                                                                devise/registrations#create
#                              root GET    /                                                                                        credentials#index
#                                   GET    /                                                                                        resources#index
#                           landing GET    /landing(.:format)                                                                       application#landing
#                 lti_user_sign_out GET    /sign_out(.:format)                                                                      users#sign_out
#                            config GET    /config(.:format)                                                                        launches#xml_config
#                           teacher GET    /teacher(.:format)                                                                       resources#teacher_backdoor
#                           student GET    /student(.:format)                                                                       resources#student_backdoor
#             attendance_transition PATCH  /attendances/:attendance_id/transition(.:format)                                         attendances#transition
#                          comments POST   /comments(.:format)                                                                      comments#create
#                      edit_context GET    /contexts/:id/edit(.:format)                                                             contexts#edit
#                           context GET    /contexts/:id(.:format)                                                                  contexts#show
#                                   PATCH  /contexts/:id(.:format)                                                                  contexts#update
#                                   PUT    /contexts/:id(.:format)                                                                  contexts#update
#                       credentials GET    /credentials(.:format)                                                                   credentials#index
#                                   POST   /credentials(.:format)                                                                   credentials#create
#                        credential DELETE /credentials/:id(.:format)                                                               credentials#destroy
#                            launch POST   /launch(.:format)                                                                        launches#create
#                         resources GET    /resources(.:format)                                                                     resources#index
#                     edit_resource GET    /resources/:id/edit(.:format)                                                            resources#edit
#                          resource GET    /resources/:id(.:format)                                                                 resources#show
#                                   PATCH  /resources/:id(.:format)                                                                 resources#update
#                                   PUT    /resources/:id(.:format)                                                                 resources#update
#               resubmit_submission PUT    /submissions/:id/resubmit(.:format)                                                      submissions#resubmit
#                         edit_user GET    /user/edit(.:format)                                                                     users#edit
#                              user GET    /user(.:format)                                                                          users#show
#                                   PATCH  /user(.:format)                                                                          users#update
#                                   PUT    /user(.:format)                                                                          users#update
#                rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
#         rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#                rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
#         update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#              rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create
