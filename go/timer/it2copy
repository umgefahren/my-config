package main

import (
	"bufio"
	"context"
	"encoding/json"
	"flag"
	"fmt"
	"io"
	"io/ioutil"
	"os"
	"path"
	"strings"
	"time"

	"github.com/muesli/termenv"
)

type TermTimer struct {
	Time time.Time
	Note string
	Name string
}

func utilsDir() (string, error) {
	home, err := os.UserHomeDir()
	if err != nil {
		return "", err
	}
	path := path.Join(path.Clean(home), ".util", "timer")
	return path, nil
}

func CreateUtilsDir() error {
	path, err := utilsDir()
	if err != nil {
		return err
	}
	err = os.MkdirAll(path, 0777)
	return err
}

func UtilsDirExists() (bool, error) {
	path, err := utilsDir()
	if err != nil {
		return false, nil
	}
	_, err = os.Stat(path)
	return !os.IsNotExist(err), nil
}

func (t TermTimer) SaveTimer() error {
	exists, err := UtilsDirExists()
	if err != nil {
		return err
	}
	if !exists {
		err = CreateUtilsDir()
		if err != nil {
			return err
		}
	}
	p, err := utilsDir()
	if err != nil {
		return err
	}
	timerPath := path.Join(p, fmt.Sprintf("%s.json", t.Name))
	f, err := os.Create(timerPath)
	if err != nil {
		return err
	}
	defer f.Close()
	data, err := json.Marshal(&t)
	if err != nil {
		return err
	}
	_, err = f.Write(data)
	if err != nil {
		return err
	}
	return nil
}

func (t TermTimer) timerPath() (string, error) {
	p, err := utilsDir()
	if err != nil {
		return "", err
	}
	return path.Join(p, fmt.Sprintf("%s.json", t.Name)), nil
}

func LoadTimer(name string) (TermTimer, error) {
	p, err := utilsDir()
	if err != nil {
		return TermTimer{}, err
	}
	timerPath := path.Join(p, fmt.Sprintf("%s.json", name))
	f, err := os.Open(timerPath)
	if err != nil {
		return TermTimer{}, err
	}
	data, err := io.ReadAll(f)
	if err != nil {
		return TermTimer{}, err
	}
	timer := &TermTimer{}
	err = json.Unmarshal(data, timer)
	if err != nil {
		return TermTimer{}, err
	}
	return *timer, nil
}

func (t TermTimer) PrintSince() {
	duration := time.Since(t.Time)
	fmt.Printf("Elapsed: %v\n", duration)
}

func (t TermTimer) Delete() error {
	p, err := t.timerPath()
	if err != nil {
		return err
	}
	return os.Remove(p)
}

func (t TermTimer) Print() {
	fmt.Printf("Start Time: %v\n", t.Time)
	t.PrintSince()
	fmt.Printf("Name: %s\n", t.Name)
	fmt.Printf("Note: %s\n", t.Name)
}

func ListContent() error {
	p, err := utilsDir()
	if err != nil {
		return err
	}
	files, err := ioutil.ReadDir(p)
	if err != nil {
		return err
	}
	for i, f := range files {
		fmt.Printf("I: %03d F: %s\n", i+1, path.Base(f.Name()))
	}
	return nil
}

func (t TermTimer) Live() {
	fmt.Println("Press enter to quit")
	ctx, cancel := context.WithCancel(context.Background())
	go func() {
		ticker := time.NewTicker(time.Millisecond * 100)
		for {
			select {
			case <-ctx.Done():
				termenv.ShowCursor()
				fmt.Println("Exiting")
				return
			case <-ticker.C:
				duration := time.Since(t.Time)
				durationString := fmt.Sprintf(" Duration: %v  ", duration)
				fmt.Print("\r ")
				termenv.ClearLineRight()
				fmt.Print(durationString)
			}
		}
	}()
	reader := bufio.NewReader(os.Stdin)
	reader.ReadString('\n')
	cancel()
}

var name = flag.String("n", "", "Name of timer")
var note = flag.String("note", "", "Note on timer")
var command = flag.String("c", "", "Command to pass")

func checkName() {
	if *name == "" {
		fmt.Println("Give name")
		os.Exit(1)
	}
}

func main() {
	flag.Parse()
	switch strings.TrimSpace(*command) {
	case "new", "n":
		checkName()
		fmt.Printf("Creating timer with name: %s\n", *name)
		if *note != "" {
			fmt.Printf("Note: %s\n", *note)
		}
		timer := TermTimer{
			Time: time.Now(),
			Name: *name,
			Note: *note,
		}
		err := timer.SaveTimer()
		if err != nil {
			panic(err)
		}
	case "delete", "remove", "rm":
		checkName()
		fmt.Println("Deleting timer: ", *name)
		timer, err := LoadTimer(*name)
		if err != nil {
			panic(err)
		}
		if err = timer.Delete(); err != nil {
			panic(err)
		}
	case "get", "g":
		checkName()
		timer, err := LoadTimer(*name)
		if err != nil {
			panic(err)
		}
		timer.Print()
	case "since", "s":
		checkName()
		timer, err := LoadTimer(*name)
		if err != nil {
			panic(err)
		}
		timer.PrintSince()
	case "live", "l":
		checkName()
		timer, err := LoadTimer(*name)
		if err != nil {
			panic(err)
		}
		timer.Live()
	case "list", "ll":
		err := ListContent()
		if err != nil {
			panic(err)
		}
	case "help", "h":
		fmt.Println("Commands:")
		fmt.Println(strings.Join([]string{"new", "delete", "get", "since", "live", "list", "help"}, ", "))
	default:
		fmt.Println(flag.ErrHelp.Error())
	}
}
