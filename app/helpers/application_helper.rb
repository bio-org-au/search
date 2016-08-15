# General view helpers.
module ApplicationHelper
  def new_target_id
    "#{rand(1000)}-#{rand(1000)}-#{rand(1000)}"
  end

  def ticked(s)
    "#{s} #{fa_icon('check')}".html_safe
  end

  def display_instance(instance, shown, check_apc = false)
    if instance.standalone?
      display = show_standalone_instance(instance, check_apc)
    else
      display, shown = show_relationship_instance(instance, shown)
    end
    [display, shown]
  end
 
  def show_standalone_instance(instance, apc)
    fragment = "<div class='instance-citation'>"
    fragment << instance.reference.citation_html
    fragment << ": #{instance.page}" if instance.page.present?
    fragment << "&nbsp; [#{instance.instance_type.name}]" if instance.primary?
    fragment << "&nbsp;<span class='red'>(APC)</span>" if apc 
    fragment << "</div>"
    fragment << "<ul class='indented'>"
    Instance.records_cited_by_standalone(instance).each do |cited_by|
      fragment << "<li class='compact subordinate-instance'>"
      fragment << "<span class='instance-type-name'>#{cited_by.instance_type.name}: </span>" 
      fragment << "<span class='instance-type'>"
      target_id =  "#{rand(1000)}-#{rand(1000)}-#{rand(1000)}"
      fragment << link_to(cited_by.name.full_name, plants_names_show_path(cited_by.name.id,target_id: target_id),
                          class: "drill-down-toggle",
                          data: {target_id: target_id},
                          remote: true)
      fragment << "</span>"
      fragment << "</li>"
      fragment << "<div class='drill-down hidden-xs-up' id='#{target_id}'>"
      fragment << "</div>"
    end
    fragment << "</ul>"
    fragment.html_safe
  end

  def show_relationship_instance(instance, shown)
    citing_instance = instance.this_is_cited_by
    return "", shown if shown.include?(citing_instance.id)
    shown.push(citing_instance.id)
    fragment = "<div class='instance-citation'>#{instance.reference.citation_html}</div>"
    fragment << assemble_cited_by(instance, citing_instance)
    [fragment.html_safe, shown]
  end

  def display_name_instance(name_instance, shown, check_apc = false)
    if name_instance.standalone?
      display = show_standalone_name_instance(name_instance, check_apc)
    else
      display, shown = show_relationship_name_instance(name_instance, shown)
    end
    [display, shown]
  end
 
  def show_standalone_name_instance(name_instance, apc)
    ["standalone",false]
  end
 
  def show_relationship_name_instance(name_instance, shown)
    citing_instance = name_instance.instance.this_is_cited_by
    return "", shown if shown.include?(citing_instance.id)
    shown.push(citing_instance.id)
    fragment = "<div class='instance-citation'>#{name_instance.reference.citation_html}</div>"
    fragment << assemble_cited_by(name_instance, citing_instance)
    [fragment.html_safe, shown]
  end

  def assemble_cited_by(name_instance, citing_instance)
    fragment = "<ul class='indented'>"
    Instance.records_cited_by_relationship(citing_instance).each do |cited_by|
      next unless cited_by.name.id == name_instance.name.id
      fragment << "<li class='compact subordinate-instance'>"
      target_id =  "#{rand(1000)}-#{rand(1000)}-#{rand(1000)}"
      fragment << "<span class='instance-type-name'>"
      fragment << "#{cited_by.instance_type.name} of: </span>"
      fragment << "<span class='instance-type'>"
      fragment << link_to(cited_by.this_is_cited_by.name.full_name,
                           plants_names_show_path(
                           cited_by.this_is_cited_by.name.id,
                           target_id: target_id), 
                           class: "drill-down-toggle",
                           data: {target_id: target_id},
                           remote: true)
      fragment << "</span>"
      fragment << "</li>"
      fragment << "<div class='drill-down hidden-xs-up' id='#{target_id}'>"
      fragment << "</div>"
    end
    fragment << "</ul>"
  end

  def no_results_help(size)
    if size == 0 
      "<br/><br/>You may want to alter or reduce your search string, or add wildcards."
    else
      ""
    end
  end

  def nsl_path
    Rails.configuration.nsl_path
  end

  def flora_path
    Rails.configuration.flora_path
  end

  def fauna_path
    Rails.configuration.fauna_path
  end
end

