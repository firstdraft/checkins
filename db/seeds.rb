# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin = Administrator.find_or_create_by(email:"admin@example.com") do |a|
  a.password = "password"
end

if admin.credentials.empty?
  admin.credentials.create(consumer_key:"key", consumer_secret:"secret")
end

context = Context.find_or_create_by(id: 1) do |c|
  c.title          = "Context ONE"
  c.lti_context_id = "ContextONE"
  c.credential_id  = 1
end

resource = context.resources.find_or_create_by(id: 1) do |r|
  r.lis_outcome_service_url = "http://127.0.0.1:9393/grade_passback"
  r.lti_resource_link_id = "ResourceONE"
  r.starts_on = Date.new(2018,1,1)
  r.ends_on = Date.new(2018,1,31)
  r.monday = true
  r.wednesday = true
  r.friday = true
end
