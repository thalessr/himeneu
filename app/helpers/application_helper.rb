module ApplicationHelper

  def redirect_to_profile
    if current_user.is_customer_completed?
      customer_path(current_user.customer.slug)
    elsif current_user.is_provider_completed?
      provider_path(current_user.provider.slug)
    end
  end

  def flash_message(msg)
    h(showFlashMessage(msg))
  end

  def delete_or_recovery(object)
    name = object.class.to_s.underscore
    if object.is_deleted?
      link_to send("recover_#{name.pluralize}_path",id: "#{object.slug}") ,class: "edit-button" do
         content_tag(:i, "", class: "glyphicon glyphicon-plus-sign btn-info", 'data-original-title'.to_sym => t('links.activate'), "data-toggle".to_sym => "tooltip" )
      end
    else
      link_to send("#{name}_path",object.slug), method: :delete, data: { confirm: t('links.confirm') }  ,class: "edit-button" do
         content_tag(:i, "", class: "glyphicon glyphicon-minus-sign btn-danger", 'data-original-title'.to_sym => t('links.destroy'), "data-toggle".to_sym => "tooltip" )
      end
    end
  end

  # needs improvements
  # def meta_tag(title, description, tags, image, url)
  #   content_for :meta_tag do
  #     content_tag :title, title
  #     content_tag(:meta, "", name: :description, content: description)
  #     content_tag(:meta, "", name: :keywords, content: tags)
  #     content_tag(:meta, "", property: "og:image" , content: image)
  #     content_tag(:meta, "", property: "og:url" , content: url)
  #   end
  # end

end
