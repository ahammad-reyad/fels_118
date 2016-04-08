module ApplicationHelper
  def full_title page_title = ""
    base_title = t :app_name
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def link_to_add_fields label, f_builder, assoc
    new_obj = f_builder.object.class.reflect_on_association(assoc).klass.new
    fields = f_builder.fields_for assoc, new_obj,
      child_index: "new_#{assoc}" do |builder|
      render "#{assoc.to_s.singularize}_fields", f: builder
    end
    link_to label, "#", class: "add-button",
      onclick: "add_fields(this, \"#{assoc}\",
      \"#{escape_javascript(fields)}\")", remote: true
  end

  def link_to_remove_fields label, f_builder
    field = f_builder.hidden_field :_destroy
    link = link_to label, "#", class: "remove-button",
    onclick: "remove_fields(this)", remote: true
    field + link
  end
end
