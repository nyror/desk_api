module ApplicationHelper

  def desk_case_option desk_cases
    options_for_select(
      desk_cases.map do |desk_case|
        [desk_case.headline, desk_case.id]
      end
    )
  end

  def desk_label_option desk_labels
    options_for_select(
      desk_labels.map do |desk_label|
        [desk_label.name, desk_label.id]
      end
    )
  end

end
