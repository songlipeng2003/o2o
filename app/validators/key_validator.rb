class KeyValidator < ActiveModel::EachValidator
  def validate_each(record, field, value)
    unless value.blank?
      record.errors[field] << "必须字母、数字或_-" unless value =~ /^[[:alnum:]._-]+$/
      record.errors[field] << "必须字母开头" unless value[0] =~ /[A-Za-z]/
      record.errors[field] << "包含非法字符" unless value.ascii_only?
    end
  end
end
