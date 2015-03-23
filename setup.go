package main

import (
	"log"
	"os"
	"path/filepath"
	"runtime"
)

type Tuple struct {
	Original string
	Link     string
}

const (
	VIMRC  = ".vimrc"
	GVIMRC = ".gvimrc"
)

var VIMFILES string

func main() {
	isWin := runtime.GOOS == "windows"
	if isWin {
		VIMFILES = "vimfiles"
	} else {
		VIMFILES = ".vim"
	}

	link := []Tuple{
		Tuple{"vimrc", VIMRC},
		Tuple{"gvimrc", GVIMRC},
		Tuple{"vimfiles", VIMFILES},
	}

	c, err := os.Getwd()
	if err != nil {
		log.Fatal(err)
		return
	}

	cwd, err := filepath.Abs(c)
	if err != nil {
		log.Fatal(err)
		return
	}

	var HOME string
	if isWin {
		HOME = "USERPROFILE"
	} else {
		HOME = "HOME"
	}
	h := os.Getenv(HOME)
	home, err := filepath.Abs(h)
	if err != nil {
		log.Fatal(err)
		return
	}

	for i, t := range link {
		f, err := filepath.Abs(cwd + "/" + t.Original)
		if err != nil {
			log.Fatal(err)
			return
		}

		l, err := filepath.Abs(home + "/" + t.Link)
		if err != nil {
			log.Fatal(err)
			return
		}

		link[i] = Tuple{
			Original: f,
			Link:     l,
		}
	}

	for _, t := range link {
		err = os.Remove(t.Link)
		if err != nil {
			log.Printf("", err)
			continue
		}

		log.Printf("Remove: %v", t.Link)
	}

	for _, t := range link {
		err = os.Symlink(t.Original, t.Link)
		if err != nil {
			log.Printf("", err)
			continue
		}

		log.Printf("Create symlink: %v -> %v", t.Link, t.Original)
	}
}
