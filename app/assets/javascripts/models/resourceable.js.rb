module Resourceable

  def self.included(klass)
    klass.send(:extend, ClassMethods)
  end

  def delete(&block)
    do_request(self.class.api_url(self.id), {method: "DELETE"}, &block)
  end

  def save(&block)
    if self.persisted?
      do_request(self.class.api_url(self.id), {method: "PUT"}, &block)
    else
      do_request(self.class.api_url, {}, &block)
    end
  end

  def do_request(url, options = {}, &block)
    options.merge!(data: {todo: self.attributes})
    HTTP.post(url, options) do |response|
      if response.ok? && response.json
        self.update_attributes(response.json)
      end
      yield response, self if block_given?
    end
  end

  module ClassMethods

    def api_url(id = nil)
      "/api/v1/#{self.name.tableize}/#{id}"
    end

    def all
      HTTP.get(api_url) do |response|
        objects = response.json.inject([]) do |arr, data|
          arr << self.new(data)
          arr
        end
        yield response, objects if block_given?
      end
    end

  end

end
