package main

import (
	"log"
	"os"
	"path/filepath"
	"runtime"
)

type tuple struct {
	Original string
	Link     string
}

const (
	vimrc  = ".vimrc"
	gvimrc = ".gvimrc"
)

var vimfilesDir string

func main() {
	isWin := runtime.GOOS == "windows"
	if isWin {
		vimfilesDir = "vimfiles"
	} else {
		vimfilesDir = ".vim"
	}

	link := []tuple{
		tuple{"vimrc", vimrc},
		tuple{"gvimrc", gvimrc},
		tuple{"vimfiles", vimfilesDir},
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

		link[i] = tuple{
			Original: f,
			Link:     l,
		}
	}

	for _, t := range link {
		err = os.Remove(t.Link)
		if err != nil {
			log.Printf("%v", err)
			continue
		}

		log.Printf("Remove: %v", t.Link)
	}

	for _, t := range link {
		err = os.Symlink(t.Original, t.Link)
		if err != nil {
			log.Printf("%v", err)
			continue
		}

		log.Printf("Create symlink: %v -> %v", t.Link, t.Original)
	}
}
