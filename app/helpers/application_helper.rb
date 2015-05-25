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
      link_to send("recover_#{name.pluralize}_path",id: "#{object.slug}") ,class: "btn btn-info" do
        content_tag(:span, I18n.t('links.activate'), class: "", 'data-original-title'.to_sym => t('links.activate'), "data-toggle".to_sym => "tooltip" )
      end
    elsif !object.slug.blank?
      link_to send("#{name}_path",object.slug), method: :delete, data: { confirm: t('links.confirm') }  ,class: "btn btn-danger" do
        content_tag(:span, I18n.t('links.destroy'), class: "", 'data-original-title'.to_sym => t('links.destroy'), "data-toggle".to_sym => "tooltip" )
      end
    end
  end

  def resource_class
    devise_mapping.to
  end


  #
  # For  provider or supplier account, create a "Chat" menu on header with a link to:
  # http://chat.himeneu.com/SUPPLIER-SLUG
  # ie:
  # http://chat.himeneu.com/himeneu
  #
  # For Customer account, in the suppliers list, create a button "Chat" for each supplier with a link to:
  # http://chat.himeneu.com/SUPPLIER-SLUG/CUSTOMER-SLUG
  # ie:
  # http://chat.himeneu.com/himeneu/thales
  #
  #
  def chat_url(provider = nil, msg = "")
    base_url = "http://chat.himeneu.com/"

    unless provider.blank?
      base_url += provider
      if current_user.is_customer?
        base_url += "/#{current_user.customer.slug}"
      end
      link_to base_url, target: "_blank" do
        raw(msg + ' ' +
            content_tag(:i, "",class: "fa fa-weixin", 'data-original-title'.to_sym => "Chat", "data-toggle".to_sym => "tooltip", "data-placement".to_sym => "top")
            )
      end
    end

  end

end
