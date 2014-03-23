module HomeHelper

  def option_size case_size, label_size
    case_size > label_size ? case_size : label_size
  end
end
