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

  if len(os.Args) < 3 {
    return errors.New("Needs qml and level filenames to run!")
  }

  component, err := engine.LoadFile(os.Args[1])
  if err != nil {
    return err
  }

  f := levelcontroller.NewLevelController()
  err = levelcontroller.Load(f, os.Args[2])
  if err != nil {
    return err
  }

  err = levelcontroller.Save(f, os.Args[3])
  if err != nil {
    return err
  }

  context := engine.Context()

  obj := gameobject.NewGameObject("pancho", "pancho")
  context.SetVar("object", obj)

  win := component.CreateWindow(nil)

  win.Show()
  win.Wait()
  return nil
}

// boilerplate setters intercept the setters
//func (o *Object) 
