package main

import (
	"bufio"
	"os"
	"strings"
)

func main() {
        reader := bufio.NewReader(os.Stdin)
        writer := os.Stdout
        for {
                r, _, err := reader.ReadRune()
                if err != nil {
                        return
                }
                str := string(r)
                upperCase := strings.ToUpper(str)
                uperCaseBytes := []byte(upperCase)
                writer.Write(uperCaseBytes)
        }
}
