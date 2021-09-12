# frozen_string_literal: true

class MerchantSerializer
    include FastJsonapi::ObjectSerializer
    
    attributes :id, :first_name, :last_name, :company_name

    attribute :merchant do |object| 
        object.first_name
      end
  
  end
  