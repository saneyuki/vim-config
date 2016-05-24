package main

import (
	"errors"
	"flag"
	"log"
	"os"
	"path/filepath"
	"runtime"
)

type tuple struct {
	Original string
	Link     string
}

var isClean bool
var isNeoVim bool

func main() {
	flag.BoolVar(&isClean, "clean", false, "clean links which are set up by this script")
	flag.BoolVar(&isNeoVim, "neovim", false, "running to set up for neovim")
	flag.Parse()

	if isNeoVim {
		log.Println("running for neovim")
		mainForNeoVim()
	} else {
		log.Println("running for vim")
		mainForVim()
	}
}

func mainForNeoVim() {
	xdgConfigHome := getXdgConfigHome()

	vimfilesDir := tuple{"vimfiles", "nvim"}
	vimrc := tuple{"vimrc", "nvim/init.vim"}

	cwd, err := getCwd()
	if err != nil {
		log.Fatal(err)
		return
	}

	vimfilesDir = *resolvePath(cwd, xdgConfigHome, &vimfilesDir)
	vimrc = *resolvePath(cwd, xdgConfigHome, &vimrc)

	log.Println(vimfilesDir.Original, vimfilesDir.Link)
	log.Println(vimrc.Original, vimrc.Link)

	rmSymlink(&vimrc)
	rmSymlink(&vimfilesDir)

	if !isClean {
		createSymlink(&vimfilesDir)
		createSymlink(&vimrc)
	}
}

func mainForVim() {
	isWin := runtime.GOOS == "windows"

	home, err := getHome(isWin)
	if err != nil {
		log.Fatal(err)
		return
	}

	var vimfilesDir string
	if isWin {
		vimfilesDir = "vimfiles"
	} else {
		vimfilesDir = ".vim"
	}

	link := []tuple{
		tuple{"vimrc", ".vimrc"},
		tuple{"gvimrc", ".gvimrc"},
		tuple{"vimfiles", vimfilesDir},
	}

	cwd, err := getCwd()
	if err != nil {
		log.Fatal(err)
		return
	}

	for i, t := range link {
		link[i] = *resolvePath(cwd, home, &t)
	}

	for _, t := range link {
		rmSymlink(&t)
	}

	if !isClean {
		for _, t := range link {
			createSymlink(&t)
		}
	}
}

func getCwd() (string, error) {
	c, err := os.Getwd()
	if err != nil {
		log.Fatal(err)
		return "", err
	}

	cwd, err := filepath.Abs(c)
	if err != nil {
		log.Fatal(err)
		return "", err
	}

	return cwd, nil
}

const xdgConfigHomeEnvKey = "XDG_CONFIG_HOME"

func getXdgConfigHome() string {
	v := os.Getenv(xdgConfigHomeEnvKey)
	if v == "" {
		log.Println("try to use `~/.config` as $XDG_CONFIG_HOME")

		isWin := runtime.GOOS == "windows"
		home, err := getHome(isWin)
		if err != nil {
			log.Fatal(err)
		}

		l, err := filepath.Abs(home + "/.config")
		if err != nil {
			log.Fatal(err)
		}

		v = l
	}

	path, err := filepath.Abs(v)
	if err != nil {
		log.Fatal(err)
	}

	log.Printf(path)

	return path
}

func getHome(isWin bool) (string, error) {
	var HomeKey string
	if isWin {
		HomeKey = "USERPROFILE"
	} else {
		HomeKey = "HOME"
	}

	h := os.Getenv(HomeKey)
	home, err := filepath.Abs(h)
	if home == "" {
		err = errors.New("not found $" + HomeKey)
	}

	return home, err
}

func resolvePath(cwd string, home string, t *tuple) *tuple {
	f, err := filepath.Abs(cwd + "/" + t.Original)
	if err != nil {
		log.Fatal(err)
		return nil
	}

	l, err := filepath.Abs(home + "/" + t.Link)
	if err != nil {
		log.Fatal(err)
		return nil
	}

	return &tuple{
		Original: f,
		Link:     l,
	}
}

func rmSymlink(t *tuple) bool {
	err := os.Remove(t.Link)
	if err != nil {
		log.Printf("%v", err)
		return false
	}

	log.Printf("Remove: %v", t.Link)
	return true
}

func createSymlink(t *tuple) bool {
	err := os.Symlink(t.Original, t.Link)
	if err != nil {
		log.Printf("Error: %v", err)
		return false
	}

	log.Printf("Create symlink (link -> src): %v -> %v", t.Link, t.Original)
	return true
}
