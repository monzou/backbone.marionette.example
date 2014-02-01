Model = CRUD.module "Model"

class Model.User extends Backbone.Model

class Model.Users extends Backbone.Collection

  model: Model.User
  
class UserRepository extends Model.OnMemoryRepository

  name: "users"
  model: Model.User
  collection: Model.Users

  query: (q) ->
    return @findAll() unless q
    @where (model) ->
      for name in [ "firstName", "lastName" ] 
        attr = model.get name
        return true if attr and _.str.contains(attr.toLowerCase(), q.trim().toLowerCase())
      false

Model.UserRepository = new UserRepository
Model.UserRepository.save new Model.User firstName: "Shinji", lastName: "Okazaki"
Model.UserRepository.save new Model.User firstName: "Shinji", lastName: "Kagawa"
Model.UserRepository.save new Model.User firstName: "Keisuke", lastName: "Honda"
