class PhoneValidator < ActiveModel::EachValidator
  def validate_each(record, field, value)
    unless value.blank?
      record.errors[field] << "手机号格式错误" unless value =~ /[1-9]\d{10}/
    end
  end
end
