package gameobject

// change when we create object->sprite mapping
const SIZE = 32

type GameObject struct {
  Name, Type string
  PosX, PosY int
  SizeX int `yaml:"-"`
  SizeY int `yaml:"-"`
}

func NewGameObject(name string, objType string) *GameObject{
  obj := new(GameObject)

  obj.Name = name
  obj.Type = objType
  obj.SizeX = SIZE
  obj.SizeY = SIZE

  return obj
}
