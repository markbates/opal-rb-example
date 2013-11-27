class TodoView

  attr_accessor :todo
  attr_accessor :el

  def initialize(todo)
    self.todo = todo
    self.el = Element.new("li")
  end

  def render(options = {})
    self.el.add_class "list-group-item"
    self.el.html = <<-EOF
      <span class='subject'>
        <input type='checkbox' class='completed'>
        #{todo.subject}
      </span>
      <button type='button' class='btn btn-danger pull-right delete'>
        <span class="glyphicon glyphicon-trash"></span>
      </button>
      <button type='button' class='btn btn-primary pull-right edit'>
        <span class="glyphicon glyphicon-edit"></span>
      </button>
      <p>#{todo.updated_at.strftime("%m/%d/%Y %H:%M:%S")}</p>
      <p>#{todo.body}</p>
    EOF
    if todo.completed
      el.find(".completed")["checked"] = true
      el.add_class("todo-completed")
    else
      el.remove_class("todo-completed")
    end
    self.attach_events
    return self
  end

  def remove
    self.todo.delete do
      self.el.remove
    end
  end

  def edit_todo
    form = TodoFormView.new(self.todo)
    form.render
    form.el.on("close") do
      self.render
    end
  end

  private
  def attach_events
    self.el.off(:click, ".delete")
    self.el.off(:click, ".complete")
    self.el.off(:click, ".edit")

    self.el.on(:click, ".delete") do |e|
      e.stop_propagation
      self.remove
    end

    self.el.on(:click, ".edit") do |e|
      e.stop_propagation
      edit_todo
    end

    self.el.on(:click, ".completed") do |e|
      todo.completed = !todo.completed
      todo.save do |response|
        if response.ok?
          alert "Saved!"
          render
        end
      end
    end
  end

end
