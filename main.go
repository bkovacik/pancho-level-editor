package main

import (
  "gopkg.in/qml.v1"
  "fmt" 
)

func main() {
  err := qml.Run(run)
  fmt.Println(err)
}

func run() error {
  engine := qml.NewEngine()
  component, err := engine.LoadFile("pancholeveleditor.qml")
  if err != nil {
    return err
  }

  win := component.CreateWindow(nil)
  
  win.Show()
  win.Wait()
  return nil
}


