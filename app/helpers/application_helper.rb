module ApplicationHelper
  
  def error_messages_for(object)
    render(:partial => 'application/error_messages', :locals => {:object => object})
  end
  
  def status_tag(boolean, options={})
    puts "Deepak ::"
    puts boolean
    options[:true_text] ||=' '
    options[:false_text] ||=''
    
    if boolean
      content_tag(:spam, options[:true_text], :class => "status true")
    else
      content_tag(:spam, options[:false_text], :class => "status false")
    end
  end
end
