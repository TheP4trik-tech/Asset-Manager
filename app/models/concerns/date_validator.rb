module DateValidator
  extend ActiveSupport::Concern

private
def date_not_in_future?(attribute)
  date = send(attribute)
  if date.present? && date > Date.today
    errors.add(attribute, "can't be in the future")
  end
end

end