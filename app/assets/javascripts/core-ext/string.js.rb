`String.Inflector.plural(/(.+)do/gi, '$1dos')`

class String

  def underscore
    `this.underscore()`
  end

  def pluralize
    `this.pluralize()`
  end

  def tableize
    underscore.pluralize
  end

end
