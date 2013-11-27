class TodoFormView

  attr_accessor :todo
  attr_accessor :el

  def initialize(todo)
    self.todo = todo
    self.el = Element["#todo-form"]
  end

  def render
    self.el.html = <<-EOF
      <hr>
      <h2>New Todo</h2>
      <div class="form-group">
        <label for="subject">Subject</label>
        <input type="text" class="form-control" id="subject" placeholder="Subject">
      </div>
      <div class="form-group">
        <label for="body">Body</label>
        <textarea class="form-control" rows="3" id="body"></textarea>
      </div>
      <button type="submit" class="btn btn-primary save">Submit</button>
      <button type="submit" class="btn btn-warning cancel">Cancel</button>
    EOF

    if todo.persisted?
      el.find("h2").text = "Edit #{todo.subject}"
    end

    %w{subject body}.each do |attr|
      s = self.el.find("##{attr}")
      s.value = todo.send(attr)
    end
    self.attach_events
    return self
  end

  def remove
    self.el.html = ""
  end

  def save
    %w{subject body}.each do |attr|
      todo.send("#{attr}=", self.el.find("##{attr}").value)
    end
    todo.save do |response|
      if response.ok?
        alert "Saved!"
        self.el.trigger("close")
        self.remove
      else
        msg = []
        response.json.each do |key, errors|
          errors.each do |error|
            msg << "#{key} #{error}"
          end
        end
        alert msg.join("\n")
      end
    end
  end

  private
  def attach_events
    self.el.off(:click, ".cancel")
    self.el.off(:click, ".save")

    self.el.on(:click, ".cancel") do |e|
      e.stop_propagation
      self.remove
    end

    self.el.on(:click, ".save") do |e|
      e.stop_propagation
      self.save
    end
  end

end
