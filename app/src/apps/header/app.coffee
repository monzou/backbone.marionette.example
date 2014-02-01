Header = CRUD.module "Header"

CRUD.addInitializer ->
  controller = new Header.Controller CRUD.headerRegion
  CRUD.on "initialize:after", -> controller.show()
  