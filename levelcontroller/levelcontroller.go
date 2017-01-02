package levelcontroller

import (
  "bufio"
  "os"
  "path/filepath"
  "gopkg.in/yaml.v2"
  "pancho-level-editor/gameobject"
  "pancho-level-editor/spriteobject"
  "pancho-level-editor/atlasobject"
//  "fmt"
)

type LevelController struct {
  SizeX, SizeY, OriX, OriY int
  Gravity float32
  Objects []gameobject.GameObject
}

type SpriteContainer struct {
  Sprites map[string]map[string]spriteobject.SpriteObject
}

type AtlasContainer struct {
  SizeX, SizeY int
  Sprites map[string]atlasobject.AtlasObject
}

type unmarshallable interface {
  isUnmarshallable() bool
}

func (lc *LevelController) isUnmarshallable() bool { return true; }
func (sc *SpriteContainer) isUnmarshallable() bool { return true; }
func (ac *AtlasContainer)  isUnmarshallable() bool { return true; }

func NewLevelController() *LevelController {
  lc := new(LevelController)
  return lc
}

// reads in file of name unmarshalls to u
func load(name string, u unmarshallable) (e error) {
  fullpath, err := filepath.Abs(name)
  if err != nil {
    return err
  }

  f, err := os.Open(fullpath)
  if err != nil {
    return err
  }

  defer
    func() {
      e = f.Close()
    }()

  scanner := bufio.NewScanner(f)

  // parse YAML
  var a string
  for scanner.Scan() {
    if err != nil {
      return err
    }
    a += scanner.Text() + "\n"
  }
  err = yaml.Unmarshal([]byte(a), u);
  if err != nil {
    return err
  }

  return nil
}

func (lc *LevelController) Load(name string, sname string, aname string) (e error) {
  err := load(name, lc)
  if err != nil {
    return err
  }

  var sc SpriteContainer
  err = load(sname, &sc)
  if err != nil {
    return err
  }

  var ac AtlasContainer
  err = load(aname, &ac)
  if err != nil {
    return err
  }

  // change this when object->sprite mapping created
  i := 0
  for i < len(lc.Objects) {
    obj := &lc.Objects[i]

    base := sc.Sprites[obj.Type]["base"]
    if base.CusX != 0 {
      obj.CusX = base.CusX
      obj.CusY = base.CusY
    }

    aobj := ac.Sprites[base.Sprite]
    obj.SpriteX = aobj.BegX
    obj.SpriteY = aobj.BegY
    obj.SizeX = aobj.EndX - aobj.BegX
    obj.SizeY = aobj.EndY - aobj.BegY

    i++
  }

  return nil
}

func (lc *LevelController) Save(name string) (e error) {
  fullpath, err := filepath.Abs(name)
  if err != nil {
    return err
  }

  f, err := os.OpenFile(fullpath, os.O_CREATE|os.O_WRONLY, 666)
  if err != nil {
    return err
  }

  defer
    func() {
      e = f.Close()
    }()

  writer := bufio.NewWriter(f)

  a, err := yaml.Marshal(lc)
  if err != nil {
    return err
  }
  _, err = writer.Write(a)
  if err != nil {
    return err
  }
  err = writer.Flush()
  if err != nil {
    return err
  }

  return err
}

//qml getters and setters
func (lc *LevelController) ObjectsLength() (i int) {
  return len(lc.Objects)
}

func (lc *LevelController) ObjectsG (i int) (g gameobject.GameObject) {
  return lc.Objects[i]
}
