# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :administrators

  authenticated :administrator do
    root "credentials#index"
  end

  root "contexts#index"

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
  resources :check_ins, only: %i[create destroy edit show update]
  resources :contexts, only: %i[index edit update show]
  resources :credentials, only: %i[index create destroy]
  resources :enrollments, only: []
  resource  :launch, only: :create
  resources :meetings
  resources :resources, only: %i[edit update show]
  resource :user, only: %i[edit show update]
end

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
#                                   GET    /                                                                                        contexts#index
#                           landing GET    /landing(.:format)                                                                       application#landing
#                 lti_user_sign_out GET    /sign_out(.:format)                                                                      users#sign_out
#                            config GET    /config(.:format)                                                                        launches#xml_config
#                           teacher GET    /teacher(.:format)                                                                       resources#teacher_backdoor
#                           student GET    /student(.:format)                                                                       resources#student_backdoor
#             attendance_transition PATCH  /attendances/:attendance_id/transition(.:format)                                         attendances#transition
#                         check_ins POST   /check_ins(.:format)                                                                     check_ins#create
#                     edit_check_in GET    /check_ins/:id/edit(.:format)                                                            check_ins#edit
#                          check_in GET    /check_ins/:id(.:format)                                                                 check_ins#show
#                                   PATCH  /check_ins/:id(.:format)                                                                 check_ins#update
#                                   PUT    /check_ins/:id(.:format)                                                                 check_ins#update
#                                   DELETE /check_ins/:id(.:format)                                                                 check_ins#destroy
#                          contexts GET    /contexts(.:format)                                                                      contexts#index
#                      edit_context GET    /contexts/:id/edit(.:format)                                                             contexts#edit
#                           context GET    /contexts/:id(.:format)                                                                  contexts#show
#                                   PATCH  /contexts/:id(.:format)                                                                  contexts#update
#                                   PUT    /contexts/:id(.:format)                                                                  contexts#update
#                       credentials GET    /credentials(.:format)                                                                   credentials#index
#                                   POST   /credentials(.:format)                                                                   credentials#create
#                        credential DELETE /credentials/:id(.:format)                                                               credentials#destroy
#                            launch POST   /launch(.:format)                                                                        launches#create
#                          meetings GET    /meetings(.:format)                                                                      meetings#index
#                                   POST   /meetings(.:format)                                                                      meetings#create
#                       new_meeting GET    /meetings/new(.:format)                                                                  meetings#new
#                      edit_meeting GET    /meetings/:id/edit(.:format)                                                             meetings#edit
#                           meeting GET    /meetings/:id(.:format)                                                                  meetings#show
#                                   PATCH  /meetings/:id(.:format)                                                                  meetings#update
#                                   PUT    /meetings/:id(.:format)                                                                  meetings#update
#                                   DELETE /meetings/:id(.:format)                                                                  meetings#destroy
#                     edit_resource GET    /resources/:id/edit(.:format)                                                            resources#edit
#                          resource GET    /resources/:id(.:format)                                                                 resources#show
#                                   PATCH  /resources/:id(.:format)                                                                 resources#update
#                                   PUT    /resources/:id(.:format)                                                                 resources#update
#                         edit_user GET    /user/edit(.:format)                                                                     users#edit
#                              user GET    /user(.:format)                                                                          users#show
#                                   PATCH  /user(.:format)                                                                          users#update
#                                   PUT    /user(.:format)                                                                          users#update
#                rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
#         rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#                rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
#         update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#              rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create
