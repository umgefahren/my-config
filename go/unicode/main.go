package main

import (
	"fmt"
	"os"
)


func main() {
        if len(os.Args) != 2 {
                fmt.Println("Pass one argument")
        }
        arg := os.Args[1]
        for _, r := range arg {
                fmt.Printf("Rune: %s Unicode: %U\n", string(r), r)
        }
}
