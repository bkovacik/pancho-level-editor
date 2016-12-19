package main

import (
  "gopkg.in/qml.v1"
  "fmt"
  "os"
  "errors"
)

type Object struct {
  Name, Type string
  PosX, PosY, SizeX, SizeY int
}

func main() {
  err := qml.Run(run)

  if err != nil {
    fmt.Println(err)
  }
}

func run() error {
  engine := qml.NewEngine()

  if len(os.Args) == 1 {
    return errors.New("Needs qml filename to run!")
  }

  component, err := engine.LoadFile(os.Args[1])
  if err != nil {
    return err
  }

  context := engine.Context()

  obj := Object{Name: "pancho", Type: "pancho"}
  context.SetVar("object", &obj)

  win := component.CreateWindow(nil)

  win.Show()
  win.Wait()
  return nil
}

// boilerplate setters intercept the setters
//func (o *Object) 
