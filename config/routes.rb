Rails.application.routes.draw do
  # Routes for the Launch resource:

  # CREATE
  get("/launches/new", { :controller => "launches", :action => "new_form" })
  post("/create_launch", { :controller => "launches", :action => "create_row" })

  # READ
  get("/launches", { :controller => "launches", :action => "index" })
  get("/launches/:id_to_display", { :controller => "launches", :action => "show" })

  # UPDATE
  get("/launches/:prefill_with_id/edit", { :controller => "launches", :action => "edit_form" })
  post("/update_launch/:id_to_modify", { :controller => "launches", :action => "update_row" })

  # DELETE
  get("/delete_launch/:id_to_remove", { :controller => "launches", :action => "destroy_row" })

  #------------------------------

  # Routes for the Enrollment resource:

  # CREATE
  get("/enrollments/new", { :controller => "enrollments", :action => "new_form" })
  post("/create_enrollment", { :controller => "enrollments", :action => "create_row" })

  # READ
  get("/enrollments", { :controller => "enrollments", :action => "index" })
  get("/enrollments/:id_to_display", { :controller => "enrollments", :action => "show" })

  # UPDATE
  get("/enrollments/:prefill_with_id/edit", { :controller => "enrollments", :action => "edit_form" })
  post("/update_enrollment/:id_to_modify", { :controller => "enrollments", :action => "update_row" })

  # DELETE
  get("/delete_enrollment/:id_to_remove", { :controller => "enrollments", :action => "destroy_row" })

  #------------------------------

  # Routes for the Credential resource:

  # CREATE
  get("/credentials/new", { :controller => "credentials", :action => "new_form" })
  post("/create_credential", { :controller => "credentials", :action => "create_row" })

  # READ
  get("/credentials", { :controller => "credentials", :action => "index" })
  get("/credentials/:id_to_display", { :controller => "credentials", :action => "show" })

  # UPDATE
  get("/credentials/:prefill_with_id/edit", { :controller => "credentials", :action => "edit_form" })
  post("/update_credential/:id_to_modify", { :controller => "credentials", :action => "update_row" })

  # DELETE
  get("/delete_credential/:id_to_remove", { :controller => "credentials", :action => "destroy_row" })

  #------------------------------

  # Routes for the Context resource:

  # CREATE
  get("/contexts/new", { :controller => "contexts", :action => "new_form" })
  post("/create_context", { :controller => "contexts", :action => "create_row" })

  # READ
  get("/contexts", { :controller => "contexts", :action => "index" })
  get("/contexts/:id_to_display", { :controller => "contexts", :action => "show" })

  # UPDATE
  get("/contexts/:prefill_with_id/edit", { :controller => "contexts", :action => "edit_form" })
  post("/update_context/:id_to_modify", { :controller => "contexts", :action => "update_row" })

  # DELETE
  get("/delete_context/:id_to_remove", { :controller => "contexts", :action => "destroy_row" })

  #------------------------------

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
