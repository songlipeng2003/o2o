module Tree
  extend ActiveSupport::Concern

  included do
    has_ancestry orphan_strategy: :destroy,
      cache_depth: true

    def name_for_selects
      "#{'|' if depth > 0}" + "#{'-' * depth} #{name}"
    end
  end

  module ClassMethods
    def arrange_as_array(options={}, hash=nil)
      hash ||= arrange(options) unless hash.is_a? Array

      arr = []

      hash.each do |node, children|
        arr << node
        arr += arrange_as_array(options, children) unless children.nil?
      end
      arr
    end

    def ancestry_options(items, &block)
      return ancestry_options(items){ |i| i.name_for_selects } unless block_given?

      result = []
      items.map do |item, sub_items|
        result << [yield(item), item.id]
        #this is a recursive call:
        result += ancestry_options(sub_items, &block)
      end
      result
    end
  end

end
