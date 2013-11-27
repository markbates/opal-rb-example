class Model
  include Resourceable

  attr_accessor :attributes

  def initialize(attrs = {})
    update_attributes(attrs)
  end

  def persisted?
    !!self.id
  end

  def update_attributes(data = {})
    data["updated_at"] = Time.parse(data["updated_at"])
    data["created_at"] = Time.parse(data["created_at"])
    self.attributes = data
  end

  def method_missing(name, *args, &block)
    name = name.to_s
    if matches = /(.+)=$/.match(name)
      name = matches[1]
      self.attributes[name] = args.first
    end
    self.attributes[name.to_s]
  end

  def inspect
    {class: self.class.name, attributes: self.attributes}.inspect
  end

end
