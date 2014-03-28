class Todo.TasksController extends Todo.ApplicationController
  routingKey: 'tasks'

  @beforeAction 'fetchTask', only: ['show', 'edit']

  index: (params) ->
    @set('tasks', Todo.Task.get('all'))

  show: (params) ->

  edit: (params) ->

  new: (params) ->
    @set('task', new Todo.Task)

  create: (params) ->
    @task.save (err, task) =>
      if err
        throw err unless err instanceof Batman.ErrorsSet
      else
        @redirect task

  update: (params) ->
    @task.save (err, task) =>
      if err
        throw err unless err instanceof Batman.ErrorsSet
      else
        @redirect task

  destroy: (node, event, context) ->
    task = if context.get('task') then context.get('task') else @task
    task.destroy (err) =>
      if err
        throw err unless err instanceof Batman.ErrorsSet
      else
        @redirect '/tasks'

  fetchTask: (params) ->
    Todo.Task.find params.id, @errorHandler (task) =>
      @set('task', task)