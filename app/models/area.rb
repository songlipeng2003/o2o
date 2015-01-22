class Area < ActiveRecord::Base
  include Tree

  validates :name, presence: :true

  def self.provinces
    self.where(ancestry_depth: 0).all
  end

  def as_tree_json
    to_json(:include => { :children =>
      { :include => { :children => {
        :include => { :children => {  } }
      } } }
    })
  end
end
