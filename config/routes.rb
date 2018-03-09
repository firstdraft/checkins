Rails.application.routes.draw do
  # Routes for the Check in resource:

  # CREATE
  get("/check_ins/new", { :controller => "check_ins", :action => "new_form" })
  post("/create_check_in", { :controller => "check_ins", :action => "create_row" })

  # READ
  get("/check_ins", { :controller => "check_ins", :action => "index" })
  get("/check_ins/:id_to_display", { :controller => "check_ins", :action => "show" })

  # UPDATE
  get("/check_ins/:prefill_with_id/edit", { :controller => "check_ins", :action => "edit_form" })
  post("/update_check_in/:id_to_modify", { :controller => "check_ins", :action => "update_row" })

  # DELETE
  get("/delete_check_in/:id_to_remove", { :controller => "check_ins", :action => "destroy_row" })

  #------------------------------

  devise_for :administrators
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
