package main

import (
	"flag"
	"fmt"
	"os"
)

var str = flag.String("s", "", "You can, alternativly, pass a string directly")

func PrintUnicode(inp string) {
        for _, r := range inp {
                fmt.Printf("Rune: %s Unicode: %U\n", string(r), r)
        }
}

func main() {
        flag.Parse()
        if *str != "" {
                PrintUnicode(*str)
                return
        }
        if len(os.Args) != 2 {
                fmt.Println("Pass one argument")
                return 
        }
        arg := os.Args[1]
        PrintUnicode(arg)
}
