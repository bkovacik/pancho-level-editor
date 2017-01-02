package gameobject

/*import (
  "gopkg.in/qml.v1"
)*/

// change when we create object->sprite mapping
const SIZE = 32

type GameObject struct {
  Name, Type string
  PosX, PosY int

  // CusX is size on screen
  CusX int `yaml:"-"`
  CusY int `yaml:"-"`

  // SpriteX is position grabbed from Atlas
  SpriteX int `yaml:"-"`
  SpriteY int `yaml:"-"`
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
