package levelcontroller

import (
  "bufio"
  "os"
  "path/filepath"
  "gopkg.in/yaml.v2"
  "pancho-level-editor/gameobject"
)

type LevelController struct {
  SizeX, SizeY, OriX, OriY int
  Gravity float32
  Objects []gameobject.GameObject
}

func NewLevelController() *LevelController {
  lc := new(LevelController)
  return lc
}

func Load(lc *LevelController, name string) (e error) {
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
  err = yaml.Unmarshal([]byte(a), lc);
  if err != nil {
    return err
  }
  // change this when object->sprite mapping created
  i := 0
  for i < len(lc.Objects) {
    lc.Objects[i].SizeX = 32
    lc.Objects[i].SizeY = 32
    i++
  }

  return err
}

func Save(lc *LevelController, name string) (e error) {
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
