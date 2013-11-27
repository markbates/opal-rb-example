# == Schema Information
#
# Table name: todos
#
#  id         :integer          not null, primary key
#  subject    :string(255)      not null
#  body       :text             not null
#  completed  :boolean          not null
#  created_at :datetime
#  updated_at :datetime
#

class Todo < ActiveRecord::Base
  validates :subject, presence: true
  validates :body, presence: true
end
