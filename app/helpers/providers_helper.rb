module ProvidersHelper
  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize , :f => builder)
    end
    link_to(name,'#', :onclick => h("add_fields(this, \"#{association}\", \"#{j(fields)}\")"))
  end

  # def self_profile?(current_profile)
  #   unless current_user.is_customer?
  #     current_user.provider_id == current_profile.id
  #   end
  # end

end


