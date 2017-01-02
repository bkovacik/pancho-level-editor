package main

import (
  "gopkg.in/qml.v1"
  "fmt"
  "os"
  "errors"
  "pancho-level-editor/levelcontroller"
  "pancho-level-editor/gameobject"
)

func main() {
  err := qml.Run(run)

  if err != nil {
    fmt.Println(err)
  }
}

func run() error {
  engine := qml.NewEngine()

  if len(os.Args) < 4 {
    return errors.New("Needs qml and level filenames to run!")
  }

  component, err := engine.LoadFile(os.Args[1])
  if err != nil {
    return err
  }

  f := levelcontroller.NewLevelController()
  err = f.Load(os.Args[2], os.Args[3], os.Args[4])
  if err != nil {
    return err
  }

  err = f.Save(os.Args[5])
  if err != nil {
    return err
  }

  context := engine.Context()

  obj := gameobject.NewGameObject("pancho", "pancho")

  context.SetVar("object", obj)
  context.SetVar("lc", f)
  //context.SetVar("getNumObjects", levelcontroller.GetNumObjects)

  win := component.CreateWindow(nil)

  win.Show()
  win.Wait()
  return nil
}

// boilerplate setters intercept the setters
//func (o *Object) 
