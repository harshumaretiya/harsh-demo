# frozen_string_literal: true

class TodoSerializer
  include FastJsonapi::ObjectSerializer
  
  attributes :id, :title, :desc, :status, :user_id, :due_date, files: []

end
